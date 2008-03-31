import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;
class be.netdust.visual.assembler.expert.MethodExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	public static function getInstance( _oOwner:IAssembler ) : MethodExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.METHOD_EXPERT ) )
		{
			var _oInstance:MethodExpert = new MethodExpert( _oOwner );
		};		
		return MethodExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.METHOD_EXPERT ) );
	};
	
	private function MethodExpert( _oOwner:IAssembler )
	{
		super( ExpertList.METHOD_EXPERT, _oOwner );
	}
	
	public function buildPropertyMethod( _instance, _fncstring:String  ) 
	{			
	/*
		_instance.setOnCommand( { fnc:_fncstring.split("(")[0], 
								  arg: PropertyExpert.getInstance().deserializeArguments( _fncstring.split("(")[1].split(")")[0], _scope, _instance ) 
								} 
							  );
	*/
	};
	
	public function buildEventMethod( _fnc:String )
	{
		var tokens:Array = _fnc.split("(").slice(0,1).concat( _fnc.split("(")[1].split(")")[0] );
		/*
		if( tokens[0].indexOf(".") != - 1 )
		{
			var a : Array = tokens[0].split(".");
			var oRef = IDExpert.getInstance().locate( String(a.shift()) );
			return eval( oRef + "." + (a.join(".")) );
		};	
		*/
	}
	
	


}