import com.bourre.core.ILocator;
import com.bourre.data.collections.Map;
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.Expert;
class be.netdust.visual.assembler.expert.ExpertLocator 
	implements ILocator
{
	private static var _M : Map = new Map();
	
	private var _owner : IAssembler;
	private var _m : Map;
	
	private function ExpertLocator( owner : IAssembler ) 
	{
		_owner = owner;
		_m = new Map();
	}
	
	public static function getInstance( owner : IAssembler ) : ExpertLocator
	{
		if ( !(ExpertLocator._M.containsKey( owner )) ) ExpertLocator._M.put( owner, new ExpertLocator(owner) );
		return ExpertLocator._M.get( owner );
	}
	
	public function getOwner() : IAssembler
	{
		return _owner;
	}
	
	public function isRegistered( key : String ) : Boolean 
	{
		return _m.containsKey( key );
	}

	public function locate( key : String )
	{
		if ( !(isRegistered( key )) ) trace( "Can't locate Expert instance with '" + key + "' name in " + this );
		return _m.get( key );
	}
	
	public function getExpert( key : String ) : Expert
	{
		return locate( key );
	}
	
	public function registerExpert( key : String, o : Expert ) : Boolean
	{
		if ( isRegistered( key ) )
		{
			trace( "Expert instance is already registered with '" + key + "' name in " + this );
			return false;
			
		} else
		{
			_m.put( key, o );
			return true;
		}
	}
	
	public function unregisterExpert( key : String ) : Void
	{
		_m.remove( key );
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this ) + (_owner?", owner: "+_owner:"No owner.");
	}
}