/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.events.StringEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.bourre.commands.Delegate;

import com.bourre.data.collections.Map;
import com.bourre.data.iterator.ArrayIterator;

import com.bourre.log.PixlibDebug;
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.assembler.View;
import be.netdust.visual.assembler.ViewAssembler;
import be.netdust.visual.assembler.parser.ViewNodeNameList;
import be.netdust.visual.assembler.parser.ViewAttributeList;

class be.netdust.visual.assembler.ViewParser 
extends com.bourre.data.libs.AbstractXMLToObjectDeserializer
{
	private var _m : Map;
	
  	public static function stripSpaces(s:String) : String 
	{
		var beg = 0, end = String(s).length-1;				
		while (!isNaN(" "+s.charAt(beg)+" 0") ) beg++;
		while (!isNaN(" "+s.charAt(end)+" 0") ) end--;	
		return s.slice(beg, end+1);
  	}
  	
	/** 
	* constructor
	*/
	public function ViewParser( assembler : ViewAssembler ) 
	{
		_oEB = new EventBroadcaster( this );
		_oAssembler = assembler;
		_aIA = new Array();
		_m = new Map();

		addType( ViewNodeNameList.STYLE,  this, _deserializeStyleNode );
		addType( ViewNodeNameList.DATA,   this, _deserializeDataNode );
		addType( ViewNodeNameList.VIEW,   this, _deserializeViewNode );
		addType( ViewNodeNameList.SCRIPT, this, _deserializeScriptNode );
	}

	/**
	 * Add new type to deserializer
	 */
	public function addType( type : String, scopeMethod, parsingMethod : Function ) : Void
	{
		_m.put( type, new Delegate( scopeMethod, parsingMethod ) );
	}
	
	/**
	 * Remove type to deserializer
	 */
	public function removeType( type : String ) : Void
	{
		_m.remove( type );
	}
	
	/**
	 * Deserialize XMLToObject's node.
	 */
	public function deserialize( target, node:XMLNode ) : Void
	{
		var _sNodeType:String = node.attributes.type;
		if (!_sNodeType) _sNodeType = node.nodeName;

		if ( _m.containsKey( _sNodeType ) )
		{
			var d:Delegate = _m.get( _sNodeType );
			d.setArguments( node );
			d.callFunction();
		};
	}
	
	public function deserializeAttributes( _owner )
	{
		var iterator:ArrayIterator = new ArrayIterator( _aIA );
		
		while( iterator.hasNext() )
		{
			var ia:Object = iterator.next();
			_oAssembler.buildAttributeProperty( ia.instance, ia.attributes );
			
		
			if( ia.attributes.tooltip )
			_oAssembler.buildToolTip( ia.instance, String( ia.attributes["tooltip"] ) );
			
			if( ia.attributes.keyaccess )
			_oAssembler.buildKeyAccess( ia.instance, ia.attributes.keyaccess );
		
		};
		
		_owner.onViewParsingEnd( );
	}

  	/**
  	 * Returns the string representation of this instance.
  	 * @return the string representation of this instance
  	 */
  	public function toString() : String 
  	{
  		return PixlibStringifier.stringify( this );
  	}
	
	//
	
	private function _deserializeScriptNode( node : XMLNode ) : Void
	{
		_oAssembler.buildScript( stripSpaces( node.firstChild.nodeValue ) );
	}
	
	private function _deserializeStyleNode( node : XMLNode ) : Void
	{
		_oAssembler.buildStyle( stripSpaces( node.firstChild.nodeValue ) );
	}

	private function _deserializeDataNode( node : XMLNode ) : Void
	{
		var _sID:String = ViewAttributeList.getID( node.attributes );
		_oAssembler.buildDataProvider( _sID, node.childNodes );
	}
	
	private function _deserializeViewNode( node : XMLNode ) : Void
	{
		var _sView:String = ViewAttributeList.getID( node.attributes );
			
		if( _sView == undefined ) PixlibDebug.DEBUG( "error: an id must be set on view node!" );
		var instance = _oAssembler.buildViewContainer( _sView );	
			
		_oAssembler.buildAttributeProperty( instance, node.attributes  );
		_owner.getObject()["applicationViewID"] = _sView;
		_owner.getObject()[_sView] = instance;
		
		_parseViewNode( node.nodeName, node.childNodes, instance );
	}
	
	private function _parseViewNode( nodeName : String, node, parent ) : Void
	{
		if( node instanceof Array ) 
		{			
			var l : Number = node.length;		
			if ( l > 0 ) 
			{
				for ( var i : Number = 0; i < l; i++ ) {
					_parseViewNode( node[i].nodeName, node[i], parent );
				}
				return;
			}			
		};

		var instance = _parseInstanceNode( nodeName, node );
		
		if( parent != undefined && instance!=undefined ) 
		parent.addChild( instance );	
		
		if( node.hasChildNodes() ) 
		_parseViewNode( node.firstChild.nodeName, node.childNodes, instance );
	};
	
	private function _parseInstanceNode( nodeName : String, node )
	{
		var id : String = ViewAttributeList.getID( node.attributes );
		var style : String = ViewAttributeList.getStyle( node.attributes );		
		var label : String = ViewAttributeList.getLabel( node.attributes );	
		
		var instance = _oAssembler.buildComponent( nodeName, id, style, label );		
		_aIA.push( { instance:instance, attributes:node.attributes } );	
		return instance;
	};
	
	
	private var _oAssembler : ViewAssembler;	
	private var _oEB : EventBroadcaster;
	private var _aIA : Array;
}