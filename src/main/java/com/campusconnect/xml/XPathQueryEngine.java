package com.campusconnect.xml;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import java.io.File;

/**
 * XPath Query Engine for querying campus.xml using standard javax.xml.xpath API.
 */
public class XPathQueryEngine {

    private String xmlPath;

    public XPathQueryEngine(String xmlPath) {
        this.xmlPath = xmlPath;
    }

    public NodeList executeQuery(String expression) {
        try {
            File xmlFile = new File(xmlPath);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);

            XPath xPath = XPathFactory.newInstance().newXPath();
            return (NodeList) xPath.compile(expression).evaluate(doc, XPathConstants.NODESET);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        String path = "xml/campus.xml";
        XPathQueryEngine engine = new XPathQueryEngine(path);

        System.out.println("=== XPath Query 1: All Department Names ===");
        NodeList depts = engine.executeQuery("/campus/departments/department/deptName");
        if (depts != null) {
            for (int i = 0; i < depts.getLength(); i++) {
                System.out.println("- " + depts.item(i).getTextContent());
            }
        }

        System.out.println("\n=== XPath Query 2: Facilities in Academic Category ===");
        NodeList acFac = engine.executeQuery("/campus/facilities/facility[category='Academic']/facName");
        if (acFac != null) {
            for (int i = 0; i < acFac.getLength(); i++) {
                System.out.println("- " + acFac.item(i).getTextContent());
            }
        }
    }
}
