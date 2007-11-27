import com.bourre.core.PropertyAccessor;


import be.netdust.visual.assembler.parser.ViewAttributeList;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.IDExpert;
import be.netdust.visual.assembler.expert.DataExpert;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.StyleExpert;
import be.netdust.visual.assembler.expert.MethodExpert;
import be.netdust.visual.assembler.expert.ExpertLocator;



class be.netdust.visual.assembler.expert.PropertyExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	
	public static function getInstance( _oOwner:IAssembler ) : PropertyExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.PROPERTY_EXPERT ) )
		{
			var _oInstance:PropertyExpert = new PropertyExpert( _oOwner );
		};		
		return PropertyExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.PROPERTY_EXPERT ) );
	};
	
	private function PropertyExpert(  _oOwner:IAssembler )
	{
		super( ExpertList.PROPERTY_EXPERT, _oOwner );
	}
	

	/**
	* builds instance values from attributes values
	* @param	_scope
	* @param	_value
	*/
	public function buildAttributeProperty( _instance, _attr:Object ) 
	{
		for( var a:String in _attr ) 
		{		
			if( !ViewAttributeList.isReserved( a ) && _attr[a].charAt(0) != "{" ) {	
				
				if( _instance[ a ] != null ) 
				{
					if ( _attr[a] == 'true' || _attr[a] == 'false' ) _attr[a] = Boolean(_attr[a])
					else if( !isNaN(_attr[a]) ) _attr[a] = Number(_attr[a])
					else _attr[a] = String(_attr[a]);
					
					_instance[ a ] = _attr[a];					
				}
				else 
				{   
					var _sMethod:String = "set"+ a.substr( 0, 1 ).toUpperCase() + a.substr( 1 );
					if( _instance[ _sMethod ] instanceof Function ) {
						_instance[ _sMethod ].apply( _instance, [ _attr[a] ] );
					}					
				}
			}
			else if( _attr[a].charAt(0) == "{" )
			{
				if( a == "dataprovider" || _attr[a].indexOf(".") != -1  ) {
					DataExpert.getInstance( getOwner() ).buildData( _instance, a, _attr[a] );
				}
				else {
					// just give refrence to object
					var _sRef:String = _attr[a].substr(1, _attr[a].length-2 );
					var _oRef = IDExpert.getInstance( getOwner() ).locate( _sRef );				
					var _sMethod:String = "set"+ a.substr( 0, 1 ).toUpperCase() + a.substr( 1 );

					if( _instance[ _sMethod ] instanceof Function ) {
						_instance[ _sMethod ].apply( _instance, [ _oRef ] );
					}	
				}
			}
			else if( ViewAttributeList.isEvent( a ) ) 
			{
				// build a command method for this property
				MethodExpert.getInstance( getOwner() ).buildEventMethod( _attr[a] );				
			}
		}
	};
	
	public function buildPropertyValue( _scope, _value:String  ) 
	{

		if( _value.indexOf(".") != -1 ) {
			
				var _aPath:Array = _value.split(".");
				var _sPath:String = String( _aPath.shift() );				
				var oRef = IDExpert.getInstance( getOwner() ).locate( String( _sPath.split("[")[0] ) );

				if( oRef ) 
				{
					if( oRef._data ) {
						var oItem = oRef.getItemAt(  _sPath.split("[")[1].split("]")[0] );
						return oItem[_aPath.join(".")];
					}

					return _buildpath( oRef, _aPath );
				}
				else 
				{
					return _buildpath( _scope, _value.split(".") );
				}
		}
		else 
		{
				if( IDExpert.getInstance( getOwner() ).locate( String( _value ) ) )
				{
					return IDExpert.getInstance( getOwner() ).locate( String( _value ) );
				}
				else 
				{
					return _scope[_value];
				}
		}
		
	}
	
	public function deserializeArguments( _sArg:String, _scope, _instance ) {
		var c:Number = 0
		var argm:Array = [];

		while(c < _sArg.length ) 
		{
			var char:String = _sArg.charAt(c);
			var arg = null;
			
			if( char == "'" || char=='"' ) 
			{
				++c
				var end:Number = _sArg.indexOf(char, c ) ;
				arg = _sArg.substr( c,  end-c );
				c = end+1;	
			} 
			else if ( char =="{" ) 
			{
				++c
				var end:Number = _sArg.indexOf('}', c ) ;
				arg = buildPropertyValue( _scope, _sArg.substr( c, end-c ) );
				c = end+1;	
			} 
			else if( char != "," && char != " ") 
			{	
				var end:Number = ( _sArg.indexOf(',') != -1 ) ? _sArg.indexOf(',', c+1 ) : _sArg.length ;
				arg = _sArg.substr( c, end-c ) == "this" ? _instance : _scope[arg] ;
				
				c = end+1;				
			}
			
					
			if( arg!=null ) argm.push( arg );
			++c;
		}
		
		return argm;
	}
	
	private function _buildpath( oRef, _aPath:Array )
	{
		while( _aPath.length ) {
			oRef = _buildpath( oRef[_aPath.shift()], _aPath )
		}
		
		return oRef;
	}

}