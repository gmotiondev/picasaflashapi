import com.bourre.core.MethodAccessor;
import com.bourre.core.PropertyAccessor;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;
import be.netdust.visual.assembler.expert.IDExpert;
import be.netdust.visual.data.DataBinding;
import be.netdust.visual.data.DataProvider;
class be.netdust.visual.assembler.expert.DataExpert
extends be.netdust.visual.assembler.expert.Expert
{
	

	public static function getInstance( _oOwner:IAssembler ) : DataExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.DATA_EXPERT ) )
		{
			var _oInstance:DataExpert = new DataExpert( _oOwner );
		};		
		return DataExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.DATA_EXPERT ) );
	};
	
	private function DataExpert( _oOwner:IAssembler )
	{
		super( ExpertList.DATA_EXPERT, _oOwner );
	}
	
	public function buildData( _instance, _prop:String, _value:String )
	{
		var id:String = _value.substr(1, _value.length-2);
		
		if( IDExpert.getInstance( getOwner() ).isRegistered( id ) )
		{
			var dp:DataProvider = IDExpert.getInstance( getOwner() ).locate( id );
			if( dp.length )
			{
				_instance.dataprovider = dp;
			}
		}
		else buildDataBinder( _instance, _prop, _value )
	}
	
	public function buildDataBinder( _instance, _prop:String, _value:String )
	{
		var _aPath:Array = _value.substr(1, _value.length-2).split(".");
		var oRef = IDExpert.getInstance( getOwner() ).locate( String( _aPath.shift() ) );	
		
		var _sSetMethod:String = "set"+ _prop.substr( 0, 1 ).toUpperCase() + _prop.substr( 1 );
		
		if( _instance[ _sSetMethod ] instanceof Function ) 
		{
			var _sGetMethod:String = "get"+ _prop.substr( 0, 1 ).toUpperCase() + _prop.substr( 1 );
			DataBinding.addBinding( new PropertyAccessor( oRef, _aPath[0] ), _aPath[1], new MethodAccessor( _instance, _instance[ _sSetMethod ], _instance[ _sGetMethod ] ) );
		}
		else DataBinding.addBinding( new PropertyAccessor( oRef, _aPath[0] ), _aPath[1], new PropertyAccessor( _instance, _prop ) );

	}
	
	
	public function buildDataProvider( _sid:String, _data ) 
	{

		if( _data[0].nodeValue != null ){
			IDExpert.getInstance( getOwner() ).register( _sid, String(_data[0].nodeValue) );
		}
		else
		if( _sid != undefined ) 
		{
			var dp:DataProvider = new DataProvider();
			var l : Number = _data.length;
			while ( l ) {		
				dp.addItem( _data[--l].attributes );
			};

			IDExpert.getInstance( getOwner() ).register( _sid, dp );
		}
	}	

}