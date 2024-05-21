import java.io.File;
import java.io.FileWriter;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;


public class Main {
    
    public static void main(String[] args) {
        try {
            XMLOutputFactory xmlOutputFactory = XMLOutputFactory.newInstance();
            XMLStreamWriter xmlStreamWriter = xmlOutputFactory.createXMLStreamWriter(new FileWriter("smartphones.xml"));
            

            // Escribir el encabezado XML
            xmlStreamWriter.writeStartDocument();
            xmlStreamWriter.writeProcessingInstruction("xml-stylesheet", "type=\"text/xsl\" href=\"operaciones.xsl\"");
            xmlStreamWriter.writeStartElement("Smartphones");

            // Escribir los datos de cada Estado
            writeEstado(xmlStreamWriter, "New York", 600, 100, 120, 180, 200);
            writeEstado(xmlStreamWriter, "Arizona", 900, 300, 110, 120, 180);
            writeEstado(xmlStreamWriter, "Nuevo México", 890, 130, 200, 380, 130);
            writeEstado(xmlStreamWriter, "Florida", 690, 140, 108, 130, 120);
            writeEstado(xmlStreamWriter, "Texas", 790, 110, 112, 180, 105);

            // Cerrar el elemento compras
            xmlStreamWriter.writeEndElement();

            // Cerrar el documento
            xmlStreamWriter.writeEndDocument();

            // Cerrar el flujo de escritura XML
            xmlStreamWriter.close();
            System.out.println("Archivo creado");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void writeEstado(XMLStreamWriter xmlStreamWriter, String nombre, int inscritos, int samsung, int apple, int xiaomi, int sin_preferencias) throws Exception {
        xmlStreamWriter.writeStartElement("Estados");
        xmlStreamWriter.writeAttribute("nombre", nombre);

        writeElement(xmlStreamWriter, "Inscritos", String.valueOf(inscritos));
        writeElement(xmlStreamWriter, "Samsung", String.valueOf(samsung));
        writeElement(xmlStreamWriter, "Apple", String.valueOf(apple));
        writeElement(xmlStreamWriter, "Xiaomi", String.valueOf(xiaomi));
        writeElement(xmlStreamWriter, "Sin_preferencias", String.valueOf(sin_preferencias));

        xmlStreamWriter.writeEndElement();
    }

    private static void writeElement(XMLStreamWriter xmlStreamWriter, String name, String value) throws Exception {
        xmlStreamWriter.writeStartElement(name);
        xmlStreamWriter.writeCharacters(value);
        xmlStreamWriter.writeEndElement();
    }
    
}
