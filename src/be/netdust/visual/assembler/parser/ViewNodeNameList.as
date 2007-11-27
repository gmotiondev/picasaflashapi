

import com.bourre.data.collections.Map;


class be.netdust.visual.assembler.parser.ViewNodeNameList
{
	private static var _oI : ViewNodeNameList;
	
	public static var BEANS : String = "bean";
	public static var SCRIPT : String = "script";
	public static var STYLE : String = "style";	
	public static var VIEW : String = "view";
	public static var DATA : String = "data";
	
	private var _mNodeName : Map;
	
	/**
	 * @return singleton instance of DefaultViewNodeNameList
	 */
	public static function getInstance() : ViewNodeNameList 
	{
		if (!_oI) _oI = new ViewNodeNameList();
		return _oI;
	}
	
	private function ViewNodeNameList()
	{
		init();
	}
	
	public function init() : Void
	{
		_mNodeName = new Map();
		
		addNodeName( ViewNodeNameList.BEANS, "" );
		addNodeName( ViewNodeNameList.SCRIPT, "" );
		addNodeName( ViewNodeNameList.STYLE, "" );
		addNodeName( ViewNodeNameList.VIEW, "" );
		addNodeName( ViewNodeNameList.DATA, "" );
	}
	
	public function addNodeName( nodeName : String, value ) : Void
	{
		_mNodeName.put( nodeName, value );
	}
	
	public function nodeNameIsReserved( nodeName ) : Boolean
	{
		return _mNodeName.containsKey( nodeName );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return "be.netdust.core.parser.ViewNodeNameList";
	}
}