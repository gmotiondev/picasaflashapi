import be.netdust.visual.tools.*;
import be.netdust.visual.managers.KeyManager;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.IDExpert;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;

class be.netdust.visual.assembler.expert.ToolExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	public static function getInstance( _oOwner:IAssembler ) : ToolExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.TOOL_EXPERT ) )
		{
			var _oInstance:ToolExpert = new ToolExpert( _oOwner );
		};		
		return ToolExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.TOOL_EXPERT ) );
	};
	
	private function ToolExpert( _oOwner:IAssembler )
	{
		super( ExpertList.TOOL_EXPERT, _oOwner );
		
	}
	
	public function buildValidator()
	{
		
	}

	public function buildKeyAccess( _instance, _key:String )
	{
		KeyManager.getInstance().addElement( _instance, _key );
	}
	
	public function buildToolTip( _instance, _value:String )
	{
		if( !IDExpert.getInstance( getOwner() ).isRegistered( "tooltip" ) )
		IDExpert.getInstance( getOwner() ).register( "tooltip", new ToolTip( ) );
		
		var _oToolTip:ToolTip = IDExpert.getInstance( getOwner()  ).locate( "tooltip" );
		_oToolTip.addElement( _instance, _value );		
		
	}
}