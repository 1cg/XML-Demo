classpath "tagsoup-1.2.1.jar,src"

uses gw.xml.simple.SimpleXmlNode
uses org.ccil.cowan.tagsoup.*
uses java.io.*
uses org.xml.sax.*

var src = "<html><body><table class='right halves'><tr></tr><tr></tr><tr><td>1</td><td>2</td><td>3</td></tr></table></body></html>"

var r = new Parser()
r.setProperty(Parser.schemaProperty, new HTMLSchema())
var w = new StringWriter()
var input = new InputSource()
input.setByteStream( new ByteArrayInputStream( src.Bytes ) )
r.ContentHandler = new XMLWriter(w)
r.parse(input)
w.flush()

var xml = w.Buffer.toString()

class Car {
  var _power : int as Power 
  var _handling : int as Handling 
  var _acceleration : int as Acceleration
  
  override function toString() : String {
    return "[Car - Power : ${Power}, Handling : ${Handling}, Accelteration : ${Acceleration}"
  }
}

var html = SimpleXmlNode.parse( xml )

var cars =
  html.Descendents
      .where( \ elt ->elt.Attributes["class"] == "right halves" and elt.Name == "table" )
      .map( \ s -> new Car() {
        :Power =  s.children("tr")[2].children("td")[0].Text.toInt(),
        :Handling =  s.children("tr")[2].children("td")[1].Text.toInt(),
        :Acceleration =  s.children("tr")[2].children("td")[2].Text.toInt()
      })

print( cars )
      