import com.bourre.events.IEvent;

import be.netdust.visual.containers.MenuPopup;
import be.netdust.visual.object.Button;
import be.netdust.visual.object.MenuItem;
class be.netdust.visual.object.Menu
extends Button
{
	public var currentItem:MenuItem = null;
	public var styleClass:String = "Menu";	
	public var isShowing:Boolean;
	
	
	public function Menu( _sValue:String, _styleID )
	{
		super( _sValue, _styleID );
	};
	
	public function addChild( _child ) 
	{
		_menupopup = _child;
		_menupopup.setParent( this );
	};
	
	public function getMenuPosition(  ) 
	{		
		var p:Object = {x:ui._parent._x, y:ui._parent._y }
		ui.localToGlobal( p );	
		
		if( getParent() instanceof MenuPopup )
		_menupopup.setPosition( p.x+width-10, p.y - height/2 );
		else _menupopup.setPosition( p.x, p.y+height );
	};
	
	public function create() : Void 
	{	
		super.create();
		_menupopup.create();
	};
	
	public function show() 
	{
		_menupopup.show();
		isShowing = true;
	};
	
	public function hide() 
	{
		_menupopup.hide();
		isShowing = false;
	};
	
	public function clear()
	{
		_menupopup.clear();
		isShowing = false;
		super.clear();
	}
	
	private function setup()
	{
		super.setup()
		
		if( getParent() instanceof MenuPopup && getStyle().getID() != "sub" )
		{
			setStyle( getStyle().getSubStyle("sub") );
			setImage( getStyle().icon );
			
			setDir( "reverse" );
		}
	};
	
	private function init() 
	{
		super.init();
		isShowing = false;
	};
	
	private function _onHit()
	{
		if( !ui.hitTest( _root._xmouse, _root._ymouse, false ) 
		&&  !_menupopup.ui.hitTest( _root._xmouse, _root._ymouse, false )
		  )
		{
			hide();
		}		
	}
	
	private function _onStateHandler( _state:String ) 
	{		
		_skin.setState( ui, _state, getStyle() );
		if( _state=="press" ) {	
			show()
			callObserver( "onClick" );
		}
		else if( _state=="over" && !isShowing ) {
			callObserver( "onMenuOver" );
		}
		else if( _state=="out" && ( getParent() instanceof MenuPopup ) ) {
			ui.onMouseMove = Delegate( this, _onHit );
		}
	};
	
	private function onClick( e:IEvent )
	{
		if( getParent() instanceof MenuPopup ){
		    MenuPopup( getParent() ).hide();
			hide()
		}
		if( currentItem != e.getTarget() ) 
		currentItem = e.getTarget();	
		   
		callObserver( "onSelect" );		
	};

	private var _focusInstance:Boolean = false;
	private var _menupopup:MenuPopup;
}