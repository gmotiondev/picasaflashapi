
import com.bourre.data.collections.Map;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;

class be.netdust.visual.assembler.expert.IDExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	private var _m : Map;

	
	/**
	 * @return messy :) singleton instance of IDExpert
	 */
	public static function getInstance( _oOwner:IAssembler ) : IDExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.ID_EXPERT ) )
		{
			var _oInstance:IDExpert = new IDExpert( _oOwner );
		};		
		return IDExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.ID_EXPERT ) );
	};
	
	private function IDExpert( _oOwner:IAssembler )
	{
		super( ExpertList.ID_EXPERT, _oOwner );
		_m = new Map();
	};
	
	public function release() {
		_m = null;
		ExpertLocator.getInstance( getOwner() ).unregisterExpert( ExpertList.ID_EXPERT  );
	};
	
	public function locate( key : String )
	{
		if ( isRegistered( key ) )
		{
			return _m.get( key );
			
		} else
		{
			trace( this + ".locate(" + key + ") fails." );
		}
	};
	
	public function isRegistered( key : String ) : Boolean
	{
		return _m.containsKey( key );
	};
	
	public function isBeanRegistered( bean ) : Boolean
	{
		return _m.containsValue( bean );
	};
	
	public function register( key : String, bean ) : Boolean
	{
		if ( !(isRegistered( key )) && !(isBeanRegistered( bean )) )
		{
			_m.put( key, bean );
			return true;
			
		} else
		{
			if ( isRegistered( key ) )
			{
				trace( this + ".register(" + key + ", " + bean + ") fails, key is already registered." );
			}
			
			if ( isBeanRegistered( bean ) )
			{
				trace( this + ".register(" + key + ", " + bean + ") fails, bean is already registered." );
			}
			
			return false;
		}
	};
	
	public function unregister( key : String ) : Boolean
	{
		if ( isRegistered( key ) )
		{
			_m.remove( key );
			return true;
			
		} else
		{
			return false;
		}
	};
	

}