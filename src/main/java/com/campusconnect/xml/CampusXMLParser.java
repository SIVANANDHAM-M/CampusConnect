package com.campusconnect.xml;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;

/**
 * Java DOM Parser Demonstration for campus.xml
 * Standard Java XML DOM Parser using javax.xml.parsers and org.w3c.dom
 */
public class CampusXMLParser {

    private String xmlFilePath;

    public CampusXMLParser(String xmlFilePath) {
        this.xmlFilePath = xmlFilePath;
    }

    public Document parseXML() {
        try {
            File xmlFile = new File(xmlFilePath);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            dbFactory.setValidating(false); // Can be set true if DTD is resolved locally
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);
            doc.getDocumentElement().normalize();
            return doc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int countDepartments() {
        Document doc = parseXML();
        if (doc != null) {
            NodeList list = doc.getElementsByTagName("department");
            return list.getLength();
        }
        return 0;
    }

    public int countFacilities() {
        Document doc = parseXML();
        if (doc != null) {
            NodeList list = doc.getElementsByTagName("facility");
            return list.getLength();
        }
        return 0;
    }

    public void printAllDepartments() {
        Document doc = parseXML();
        if (doc == null) return;

        System.out.println("Root Element: " + doc.getDocumentElement().getNodeName());
        NodeList deptList = doc.getElementsByTagName("department");
        System.out.println("Total Departments Found: " + deptList.getLength());

        for (int temp = 0; temp < deptList.getLength(); temp++) {
            Node node = deptList.item(temp);
            if (node.getNodeType() == Node.ELEMENT_NODE) {
                Element element = (Element) node;
                String code = element.getElementsByTagName("deptCode").item(0).getTextContent();
                String name = element.getElementsByTagName("deptName").item(0).getTextContent();
                String hod = element.getElementsByTagName("hod").item(0).getTextContent();
                System.out.println("Dept Code: " + code + " | Name: " + name + " | HOD: " + hod);
            }
        }
    }

    public static void main(String[] args) {
        String path = "xml/campus.xml";
        CampusXMLParser parser = new CampusXMLParser(path);
        System.out.println("--- CAMPUS XML DOM PARSER TEST ---");
        System.out.println("Departments Count: " + parser.countDepartments());
        System.out.println("Facilities Count: " + parser.countFacilities());
        parser.printAllDepartments();
    }
}
