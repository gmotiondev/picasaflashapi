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
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibEvent;

import com.bourre.events.EventBroadcaster;
import com.bourre.events.StringEvent;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;

import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectEvent;


import be.netdust.visual.assembler.View;
import be.netdust.visual.assembler.ViewParser;
import be.netdust.visual.assembler.ViewAssembler;
import be.netdust.visual.assembler.ViewBuilderEvent;

import be.netdust.visual.assembler.expert.IDExpert;

class be.netdust.visual.assembler.ViewBuilder
implements ILibListener
{

	public static var onInstanceRegisterEVENT : EventType = new EventType( "onInstanceRegister" );
	public static var onViewBuiltEVENT : EventType = new EventType( "onViewBuilt" );
	public static var onViewInitEVENT : EventType = new EventType( "onViewInit" );
	
	/**
	* @method      ViewBuilder constructor
	* @description creates an instance of ViewBuilder class
	* @usage       <code>ViewBuilder( url:String );</code>
	* 
	*/
	public function ViewBuilder(  ) 
	{
		_oAssembler = new ViewAssembler( );
		_oEB = new EventBroadcaster( this );
		_oViewLoader = new XMLToObject( new View( ), new ViewParser( _oAssembler ) )  //new XMLLoader( url, new View( ), new ViewParser( _oAssembler ) );
	}
	
	/**
	* @method      ViewBuilder.load
	* @description loads the view xml file.
	* @param       url(String) url of xml file
	* @usage       <code>ViewBuilder.load():Void;</code>
	*/
	public function load( url:String ) : Void
	{
		_oViewLoader.addEventListener( XMLToObject.onLoadInitEVENT, this, onXMLParsingDone );
		_oViewLoader.addEventListener( XMLToObject.onLoadProgressEVENT, this );
		_oViewLoader.addEventListener( XMLToObject.onTimeOutEVENT, this );
		_oViewLoader.load( url );
	}
	
	/**
	* @method      ViewBuilder.register
	* @description registers parsed view class to a specified scope and displays view
	* @param       _scope([Object]) the scope of the view methods, events, etc...
	* 
	* @usage       <code>ViewBuilder.register():Void;</code>
	*/
	public function register( _scope ) {
		
		//ScriptExpert.getInstance( _oViewInstance ).registerMethods( _scope );
		//KeyExpert
		//ToolTipExpert.getInstance( _oViewInstance );
		
		_oAssembler.create( _scope, _oViewReference["applicationViewID"] );	
		
		onViewBuilt();
		
	}
	
	/**
	* @method      ViewBuilder.unregister
	* @description registers parsed view class to a specified scope and displays view
	* 
	* @usage       <code>ViewBuilder.unregister():Void;</code>
	*/
	public function unregister( ) {
		
		//ScriptExpert.getInstance( _oViewInstance ).registerMethods( _scope );
		//ToolTipExpert.getInstance( _oViewInstance )
		
		//_oViewInstance.unregister();
	}
	
	/**
	* @method      ViewBuilder.getChildByID
	* @description get a child with it's id reference from view
	* 
	* @usage       <code>ViewBuilder.getChildByID( id:String ):Object;</code>
	* @return	   child object
	*/
	public function getChildByID( id:String ) 
	{
		return IDExpert.getInstance(_oAssembler).locate( id );
	}
	
	/**
	 * Event system
	 */	 
	public function fireEvent( e : IEvent ) : Void
	{
		_oEB.broadcastEvent( e );
	}
	
	public function addListener( oL ) : Void
	{
		_oEB.addListener( oL );
	}
	
	public function removeListener( oL ) : Void
	{
		_oEB.removeListener( oL );
	}
	
	public function addEventListener( e : EventType, oL, f : Function ) : Void
	{
		_oEB.addEventListener.apply( _oEB, arguments );
	}
	
	public function removeEventListener( e : EventType, oL ) : Void
	{
		_oEB.removeEventListener( e, oL );
	}
	
	// ILibListener
	public function onLoadInit( e : LibEvent ) : Void 
	{
		fireEvent( e );
		
	}

	public function onLoadProgress( e : LibEvent ) : Void 
	{
		fireEvent( e );
	}

	public function onTimeOut( e : LibEvent ) : Void 
	{
		fireEvent( e );
	}
	//
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return "be.netdust.visual.assembler.ViewBuilder";
	}
	
	private function onXMLParsingDone( e : IEvent ) : Void
	{
		_oViewReference = View( XMLToObjectEvent(e).getObject() );
		_oViewLoader.removeListener( this );
		
		ViewParser( XMLToObjectEvent(e).getLib().getDeserializer() ).deserializeAttributes( this );
	}
	
	private function onViewParsingEnd( e : IEvent ) : Void
	{		
		onViewInit();			
	}
	
	private function onViewInit( e : IEvent ) : Void
	{
		_oEB.broadcastEvent( new ViewBuilderEvent( ViewBuilder.onViewInitEVENT, this ) );
	}	

	private function onViewBuilt( e : IEvent ) : Void
	{
		_oEB.broadcastEvent( new ViewBuilderEvent( ViewBuilder.onViewBuiltEVENT, this ) );
	}

	private var _oViewReference:View;
	
	private var _oEB:EventBroadcaster;	
	private var _oViewParser:ViewParser;
	private var _oViewLoader:XMLToObject;
	private var _oAssembler:ViewAssembler;	
	
	
	
}