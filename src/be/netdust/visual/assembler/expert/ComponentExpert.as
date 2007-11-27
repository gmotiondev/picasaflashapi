

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.IDExpert;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;

class be.netdust.visual.assembler.expert.ComponentExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	public static var referenceExpert:Number = 0;
	public static var qualifiedClassPaths:Array = [ "_global.be.netdust.visual.",
													"_global.be.netdust.visual.object.",
													"_global.be.netdust.visual.containers."
												  ];
	
	public static function getInstance( _oOwner:IAssembler ) : ComponentExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.COMPONENT_EXPERT ) )
		{
			var _oInstance:ComponentExpert = new ComponentExpert( _oOwner );
		};		
		return ComponentExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.COMPONENT_EXPERT ) );
	};
	
	public static function createInstance(  _sPackage:String, id:String, style:String, label:String )
	{
		// mg
		var arg:Array;
		var clazz : Function = null;
		var instanceType:Number = -1;
		
		if( _sPackage == "Tabs" ) _sPackage = "HBox";
		if( _sPackage == "TabPanel" ) _sPackage = "VBox";

		while( ComponentExpert.qualifiedClassPaths[instanceType+1] != undefined ){
			clazz = eval( ComponentExpert.qualifiedClassPaths[++instanceType]+_sPackage );
			if( clazz ) break;
		}

		if( !clazz ) {
			trace( "Can't create instance of " + _sPackage + ", package not available" );
			return null;
		}
		
		var oInstance = {__constructor__:clazz, __proto__:clazz.prototype};
		
		if( label != undefined && label.charAt(0) !="{") {
			   arg = [ label, style?style:null ];
		} else arg = [ style?style:null ];

		clazz.apply(oInstance, arg);		
		oInstance.setReference( ( id!=undefined) ? id : ComponentExpert.referenceExpert++ );

		
		return oInstance;		
	}

	private function ComponentExpert( _oOwner:IAssembler )
	{
		super( ExpertList.COMPONENT_EXPERT, _oOwner );	
	}
	
	public function buildComponent( _sPackage:String, id:String, style:String, label:String ) 
	{
		var oInstance = ComponentExpert.createInstance( _sPackage, id, style, label );
		IDExpert.getInstance( getOwner() ).register( oInstance.getReference(), oInstance );

		return oInstance;
	}
	

	
	public function buildViewContainer( id:String ) 
	{
		return buildComponent( "ApplicationView", id);
	};
	
	public function createView( _scope, _instanceid:String ) 
	{

		var _instance = IDExpert.getInstance( getOwner() ).locate( _instanceid );
		_instance.setContainer( _scope );
		_instance.create();

		if( IDExpert.getInstance( getOwner() ).isRegistered( "tooltip" ) )	{
			var tooltip = IDExpert.getInstance( getOwner() ).locate( "tooltip" )
			tooltip.setup( _scope );
		}
	}	
}