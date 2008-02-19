

import com.bourre.events.ChannelBroadcaster;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;

import com.bourre.commands.Command;

import be.netdust.visual.events.*


class be.netdust.visual.events.EventDispatcher
{

	public static var ON_CLICK_EVENT:BasicEvent = new BasicEvent( new EventType("onClick") );
	
	/**
	* @method      EventDispatcher.Delegate
	* @description Creates a Delegate command
	* @usage       <code>EventDispatcher.Delegate(o:Object, f:Function):Void;</code> 
	*/
	public static function Delegate(o:Object, f:Function) : Function
	{
		var _f:Function = function()
		{	
			var tt = arguments.callee.t;
			var ff = arguments.callee.f;
			var aa = arguments.callee.a;

			return ff.apply(tt, aa);
		};

		_f.t = o;
		_f.f = f;
		_f.a = arguments.splice(2);

		return _f;
	};
	
	public function EventDispatcher()
	{
		_oEB = new ChannelBroadcaster( );		
		_oBubble = BubbleChannel.CHANNEL;
		_oObserver = ObserverChannel.CHANNEL;
	}
	
	public function setDefaultChannel( _sDef:String )
	{
		_oEB.setDefaultChannel(_sDef?_sDef:_oEB.getDefaultChannel());
	}
	
	/**
	* @method      EventDispatcher.setParent
	* @description Sets reference to the parent used to bubble events.
	* @usage       <code>EventDispatcher.setParent(p:EventDispatcher):Void;</code> 
	*/
	public function setParent( p:EventDispatcher ) : Void
	{
		_clearParentListener();
		// add parent listener
		_oEB.addEventListener( BubbleEvent.ONCOMMAND, p, _oBubble );		
		_oEB.addEventListener( BubbleEvent.ONFOCUS, p, _oBubble );		
		//		
		setObserver( p );
		_parent = p;
	};
	

	/**
	* @method      EventDispatcher.getParent
	* @description Gets reference to the parent.
	* @usage       <code>EventDispatcher.getParent():Object;</code>
	*
	* @return   Object; reference to the parent.
	*/
	public function getParent() : EventDispatcher {
		return _parent;
	};
	
	
	/**
	* @method      EventDispatcher.setObserver
	* @description Adds an observer to EventDispatcher observer channel
	* @usage       <code>EventDispatcher.setObserver(_observer):Void;</code> 
	*/
	public function setObserver( _observer ) : Void 
	{
		_oEB.getChannelDispatcher( _oObserver, this ).removeAllListeners();
		_oEB.addListener( _observer, _oObserver );
	};
	
	/**
	* @method      EventDispatcher.callObserver
	* @description Sends event to observer using observer channel.
	* @usage       <code>EventDispatcher.callObserver(f:String, arg:Array):Void;</code> 
	*/
	public function callObserver( f:String ) : Void 
	{

		if( f == BubbleEvent.ONCOMMAND && _oEB.getDefaultDispatcher().isEmpty() )
		{
			_oEB.broadcastEvent( new BubbleEvent( BubbleEvent.ONCOMMAND, this, this ), _oBubble );
		}
		else if( f == BubbleEvent.ONFOCUS || f == BubbleEvent.REGISTERFOCUS )
		{
			_oEB.broadcastEvent( new BubbleEvent( BubbleEvent.ONFOCUS, this, this, f ), _oBubble );
		}
		else {
			_oEB.broadcastEvent( new ObserverEvent( new EventType(f), this ), _oObserver );
		}
	};
	
	/**
	* @method      EventDispatcher.setOnCommand
	* @description Sets reference to a command
	* @usage       <code>EventDispatcher.setOnCommand(_fCommand:Command):Void;</code> 
	*/
	public function setOnCommand( _fCommand:Command ) : Void 
	{
		_oncommand = _fCommand;
	};
	
	/**
	* @method      EventDispatcher.getOnCommand
	* @description Gets reference to a command
	* @usage       <code>EventDispatcher.getOnCommand():Command;</code> 
	*/
	public function getOnCommand(  ) : Command 
	{
		return _oncommand;
	};
	
	/**
	* @method      EventDispatcher.onCommand
	* @description recieves a command event.
	* @usage       <code>EventDispatcher.onCommand():Void;</code> 
	*/
	public function onCommand( e:IEvent ) : Void 
	{
		if( e.getTarget().getOnCommand() != null ) e.getTarget().getOnCommand().execute();		
		_oEB.broadcastEvent( new BubbleEvent( BubbleEvent.ONCOMMAND, this, BubbleEvent(e).getSource() ), _oBubble );
	};
	
	/**
	* @method      EventDispatcher.onFocus
	* @description recieves a focus event.
	* @usage       <code>EventDispatcher.onFocus( e:IEvent ):Void;</code> 
	*/
	public function onFocus( e:IEvent ) : Void 
	{
		_oEB.broadcastEvent( new BubbleEvent( BubbleEvent.ONFOCUS, this, BubbleEvent(e).getSource(), BubbleEvent(e).getHandle() ), _oBubble );
	};
	
	/**
	* @method      EventDispatcher.dispatchEvent
	* @description dispatchs an event to listener default channel.
	* @usage       <code>EventDispatcher.dispatchEvent(e:IEvent);</code>
	*/	
	public function dispatchEvent(e:IEvent) : Void 
	{
		e.setTarget(this);
		callObserver( e.getType() );
		_oEB.broadcastEvent( e, _oEB.getDefaultChannel() );
	};
	
 	/**
	* @method      EventDispatcher.addEventListener
	* @description adds an eventlistener to EventDispatcher default channel.
	* @usage       <code>EventDispatcher.addEventListener( e : EventType, oL, f : Function  );</code>
	*/	  
    public function addEventListener( e : EventType, oL, _sChannel : String ) : Void 
	{
		if( _sChannel ) _oEB.setDefaultChannel( _sChannel );
		_oEB.addEventListener( e, oL, _oEB.getDefaultChannel() );	
    };
	
 	/**
	* @method      EventDispatcher.removeEventListener
	* @description removes an eventlistener from EventDispatcher.
	* @usage       <code>EventDispatcher.removeEventListener( e : EventType, oL  );</code>
	*/	  
    public function removeEventListener( e : EventType, oL, _sChannel : String ) : Void  
	{
		_oEB.removeEventListener( e, oL, _sChannel?_sChannel:_oEB.getDefaultChannel() )
    };
    
 	/**
	* @method      EventDispatcher.removeAllListeners
	* @description removes all listeners from EventDispatcher default channel.
	* @usage       <code>EventDispatcher.removeAllListeners(   );</code>
	*/	  
    public function removeAllListeners( ) : Void  
	{
        _oEB.getDefaultDispatcher().removeAllListeners()
    };
	
	private function _clearParentListener()
	{
		// clear bubble channel from previous listener
		_oEB.getChannelDispatcher( _oBubble, this ).removeEventListener( BubbleEvent.ONCOMMAND , _parent );
		_oEB.getChannelDispatcher( _oBubble, this ).removeEventListener( BubbleEvent.ONFOCUS , _parent );		
	}
	
	private var _oncommand:Command = null;
	private var _oEB : ChannelBroadcaster;	
	private var _parent:EventDispatcher;
	
	
	private var _oObserver:String;
	private var _oBubble:String;
	
}