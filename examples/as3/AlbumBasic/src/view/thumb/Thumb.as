package view.thumb 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import com.bourre.events.EventBroadcaster;
	
	import control.photo.PhotoChangedEvent;
	import control.thumb.ThumbClickEvent;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Thumb extends Sprite
	{
		private var id : String;
		private var title : String;
		private var r : Sprite;
		private var t : TextField;
		private var c : Object = {normal : 0xFFFFFF, selected : 0xD40073};	//colors
		
		public function Thumb(aId : String, aTitle : String)
		{
			id = aId;
			title = aTitle;
			
			addBackground(c.normal);
			addEventListener(MouseEvent.CLICK, onThumbClick);
			addEventListener(MouseEvent.MOUSE_OVER, onThumbRollOver);
			addEventListener(MouseEvent.MOUSE_OUT, onThumbRollOut);
		}
		
		private function addBackground(aColor : Number) : void
		{
			if(r == null) r = new Sprite();
			
			r.graphics.clear();
			r.graphics.beginFill(aColor);
			r.graphics.drawRect(-4, -4, 8, 8);
			r.graphics.endFill();
			
			addChild(r);
			setChildIndex(r, 0);
		}
		
		private function highlight(aTrigger : Boolean) : void
		{
			addBackground(aTrigger ? c.selected : c.normal);
		}
		
		private function onThumbRollOver(evt : MouseEvent) : void
		{		
			var f : TextFormat = new TextFormat("kroeger", 8, 0xffffff);
			
			if(t == null) t = new TextField();
			
			t.visible = true;
			t.embedFonts = true;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.background = true; t.backgroundColor = 0xe2007a;
			t.antiAliasType = AntiAliasType.NORMAL;
			t.defaultTextFormat = f;
			t.text = title; 
			
			addChild(t);
			parent.setChildIndex(this, parent.numChildren - 1);

			t.x = ((parent.x + this.x + t.width) > (stage.stageWidth)) ? -t.width : 0;  
		}
		
		private function onThumbRollOut(evt : MouseEvent) : void
		{
			t.visible = false;
		}
		
		private function onThumbClick(evt : MouseEvent) : void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ThumbClickEvent(id));
		}
		
		public function photo_changed_event(evt : PhotoChangedEvent) : void
		{
			highlight(evt.id == id);
		}
	}
}
