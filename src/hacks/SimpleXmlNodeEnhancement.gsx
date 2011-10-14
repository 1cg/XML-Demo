package hacks
uses gw.xml.simple.SimpleXmlNode

enhancement SimpleXmlNodeEnhancement : SimpleXmlNode {
  
  function children( str : String ) : List<SimpleXmlNode> {
    return this.Children.where( \ s -> s.Name == str )
  }
  
}