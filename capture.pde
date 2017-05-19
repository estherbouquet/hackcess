
import org.pcap4j.packet.*;
import org.pcap4j.core.*;
import org.pcap4j.core.PcapNetworkInterface.*;
import java.net.*;
import java.util.List;
import org.apache.commons.net.util.*;
import java.net.InetAddress;

public class DetectedTraffic {
  public String dest;
  public String src;
  public String identifiedAs;
}

HashMap<String, String> IPtoCanonical = new HashMap<String, String>();
ConcurrentLinkedQueue<InetAddress> toResolve = new ConcurrentLinkedQueue<InetAddress>();

void resolver() {
  // Les intervalles d'IP suivants correspondent à des adresses IP de réseau local.
  // Elles ne peuvent donc pas appartenir à Facebook, Google ou autre...
  // Pour référence : https://en.wikipedia.org/wiki/Private_network
  SubnetUtils privateNetworkA = new SubnetUtils("10.0.0.0/8");
  SubnetUtils privateNetworkB = new SubnetUtils("172.16.0.0/12");
  SubnetUtils privateNetworkC = new SubnetUtils("192.168.0.0/16");

  while (true) {
    InetAddress ip = toResolve.poll();
    if (ip == null) {
      delay(100);
      continue;
    }
    if (IPtoCanonical.get(ip.getHostAddress()) != null) continue;
    String hostip = ip.getHostAddress();

    if (
      privateNetworkA.getInfo().isInRange(hostip) ||
      privateNetworkB.getInfo().isInRange(hostip) ||
      privateNetworkC.getInfo().isInRange(hostip)
      ) {
      // Pour les IP du réseau local, on ne fait pas de résolution pour gagner du temps.
      // On rajoute l'ip au lieu du nom de domaine dans notre cache pour éviter de refaire les vérifications à chaque fois. 
      IPtoCanonical.put(hostip, hostip);
      continue;
    }

    String hostname = ip.getCanonicalHostName();
    println("resolve " + hostip + " -> " + hostname);
    IPtoCanonical.put(hostip, hostname);
  }
}

String getCanonical(InetAddress ip) {
  String canonical = IPtoCanonical.get(ip.getHostAddress());
  if (canonical != null) return canonical;

  toResolve.add(ip);
  return "";
}

DetectedTraffic getBaseDetection(Packet packet) {
  // On fait un traitement sur le paquet -> on le décortique :p
  IpV6Packet ipV6Packet = packet.get(IpV6Packet.class);
  IpV4Packet ipV4Packet = packet.get(IpV4Packet.class);
  //TcpPacket tcpPacket = packet.get(TcpPacket.class);

  DetectedTraffic dt = null;
  if (ipV4Packet != null) {
    dt = new DetectedTraffic();
    dt.src = getCanonical(ipV4Packet.getHeader().getSrcAddr());
    dt.dest = getCanonical(ipV4Packet.getHeader().getDstAddr());
  } else if (ipV6Packet != null) {
    dt = new DetectedTraffic();
    dt.src = getCanonical(ipV6Packet.getHeader().getSrcAddr());
    dt.dest = getCanonical(ipV6Packet.getHeader().getDstAddr());
  } else {
    //println("garbage");
  }

  return dt;
}

void capture() {
  while (true) {
    try {
      // On récupère la liste des interfaces
      List<PcapNetworkInterface> listeInterfacesReseaux = Pcaps.findAllDevs();
      for (PcapNetworkInterface i : listeInterfacesReseaux) {
        println("interface n]"+i);
        println(i.getName());
        println(i.getDescription());
        println("");
      }

      // On récupère l'interface qui nous intéresse
      PcapNetworkInterface monInterface = listeInterfacesReseaux.get(4);

      //PcapNetworkInterface monInterface = Pcaps.getDevByName("enp3s0f1");

      // On lance la capture dessus
      PcapHandle capture = monInterface.openLive(100, PromiscuousMode.PROMISCUOUS, 10000000);

      while (true) {
        //print(".");
        // On récupère un packet
        Packet packet = capture.getNextPacketEx();
        DetectedTraffic dt = getBaseDetection(packet);
        if (dt == null) continue;
        //println(dt.src);

        if (dt.dest.contains("facebook") || dt.dest.contains("fbcdn")) {
          dt.identifiedAs = "facebook";
        } else if (dt.dest.contains("1e100")) {
          dt.identifiedAs = "google";
        }

        if (
          dt != null &&
          dt.identifiedAs != null &&
          dt.identifiedAs != ""
        ) {
          packets.add(dt);
        }
      }
    } 
    catch (Exception e) {
      e.printStackTrace();
      delay(1000);
    }
  }
}