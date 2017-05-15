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

  ArrayList <String> stockageIP = new ArrayList<String>();
  stockageIP.add("192.168.137.1");//On evite de donner un nom au routeur
  stockageIP.add("192.168.137.255"); // adresse réservée au broadcast
  String ipDuReseau ="192.168.137";   
  while (true) {
    InetAddress ip = toResolve.poll();
    if (ip == null) {
      delay(100);
      continue;
    }
    if (IPtoCanonical.get(ip.getHostAddress()) != null) continue;

    String hostip = ip.getHostAddress();
    String hostname = ip.getCanonicalHostName();
    println("resolve " + hostip + " -> " + hostname);
    if (hostip.contains(ipDuReseau)&& !stockageIP.contains(hostip)) {
      stockageIP.add(hostip);
      println("NEW IP DeTECED : "+hostip);
      //hostnameToSentences.put(dt.src, Salutations);
    }

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
    int vitesseDefilement =10;
    int compteur =0;

    while (true) {
      //print(".");
      // On récupère un packet
      Packet packet = capture.getNextPacketEx();
      DetectedTraffic dt = getBaseDetection(packet);
      //println(stockageIP.size());
      if (dt == null) continue;
      //println(dt.src);



      if (dt.dest.contains("facebook") || dt.dest.contains("fbcdn")) {
        dt.identifiedAs = "facebook";
        compteur++;
      } else if (dt.dest.contains("1e100")) {
        dt.identifiedAs = "google";
        compteur++;
      }

      if (dt.identifiedAs != null && dt.identifiedAs != "" && compteur%vitesseDefilement==0) {
        Packets.add(dt);
        compteur=0;
      }
    }
  } 
  catch (Exception e) {
    e.printStackTrace();
    capture();
  }
}