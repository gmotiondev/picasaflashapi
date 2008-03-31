import com.bourre.events.EventBroadcaster;
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.ExpertLocator;
class be.netdust.visual.assembler.expert.Expert
{

	private var _oEB : EventBroadcaster;
	private var _owner:IAssembler;
	private var  _sName:String;
	

	
	private function Expert( _sName:String, _oOwner : IAssembler )
	{
		setOwner( _oOwner );
		_register( _sName );
		
		_oEB = new EventBroadcaster( this );	
	}
	
	private function _register( name : String ) : Void
	{
		_sName =  name;
		var experlocator : ExpertLocator = ExpertLocator.getInstance( getOwner() );
		
		if ( !( experlocator.isRegistered( name ) ) )
		{
			if ( experlocator.isRegistered( getName() ) ) experlocator.unregisterExpert( getName() );
			if ( experlocator.registerExpert( name, this ) ) _sName = name;
			
		} else
		{
			trace( this + ".setName() failed. '" + name + "' is already registered in ExpertLocator." );
		}
	}
	
	public function toString() : String
	{
		return PixlibStringifier.stringify( this ) + (_owner?", owner: "+_owner:"No owner.");
	}
	
	public function setOwner( _oOwner : IAssembler )
	{
		_owner = _oOwner;		
	}
	
	public function getOwner() : IAssembler
	{
		return _owner;		
	}
	
	public function getName() : String
	{
		return _sName;		
	}
}