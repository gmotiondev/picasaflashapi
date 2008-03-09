

class be.netdust.visual.assembler.parser.ViewAttributeList
{
	private function ViewAttributeList() 
	{
		//
	}	
	
	private static var ID : String = "id";
	private static var STYLE : String = "style";
	private static var LABEL : String = "label";
	private static var TOOLTIP : String = "tooltip";
	private static var KEYACCESS: String = "keyaccess";
	private static var DATAPROVIDER: String = "dataprovider";
	
	private static var ONBLUR : String = "onblur";
	private static var ONCHANGE : String = "onchange";	
	private static var ONCLICK : String = "onclick";
	private static var ONDBLCLICK : String = "ondblclick";
	private static var ONFOCUS : String = "onfocus";
	private static var ONKEYDOWN : String = "onkeydown";
	private static var ONKEYPRESS : String = "onkeypress";
	private static var ONKEYUP : String = "onkeyup";
	private static var ONLOAD : String = "onload";
	private static var ONMOUSEDOWN : String = "onmousedown";
	private static var ONMOUSEMOVE : String = "onmousemove";
	private static var ONMOUSEOUT : String = "onmouseout";
	private static var ONMOUSEOVER : String = "onmouseover";
	private static var ONMOUSEUP : String = "onmouseup";
	private static var ONSELECT : String = "onselect";
	private static var ONUNLOAD : String = "onunload";
	private static var ONCLOSE : String = "onclose";
	private static var ONCOMMAND : String = "oncommand";
	private static var ONDRAGDROP : String = "ondragdrop";
	private static var ONDRAGENTER : String = "ondragenter";
	private static var ONDRAGEXIT : String = "ondragexit";
	private static var ONDRAGGESTURE : String = "ondraggesture";
	private static var ONDRAGOVER : String = "ondragover";
	private static var ONINPUT : String = "oninput";
	private static var ONOVERFLOW : String = "onoverflow";
	private static var ONUNDERFLOW : String = "onunderflow";

	public static function isReserved( nodeAttribute ) : Boolean {
		return ( ViewAttributeList[nodeAttribute.toUpperCase()] != undefined );
	};
	
	public static function isEvent( nodeAttribute ) : Boolean {
		return ( ViewAttributeList[nodeAttribute.toUpperCase()].substr(0,2)=="on" )
	};
	
	public static function getID( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.ID ];
	}
	
	public static function getStyle( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.STYLE ];
	}
	
	public static function getLabel( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.LABEL ];
	}
	
	public static function getToolTip( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.TOOLTIP ];
	}
	
	public static function getCommand( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.ONCOMMAND ];
	}
	
	public static function getKeyAccess( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.KEYACCESS ];
	}
	
	public static function getDataProvider( nodeAttribute ) : String
	{
		return nodeAttribute[ ViewAttributeList.DATAPROVIDER ];
	}
	
}