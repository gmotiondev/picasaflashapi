package view.photo 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import control.ResizeEvent;
	import control.photo.PhotoChangedEvent;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosHolder extends AbstractView
	{	
		private var t : TextField;
		private var r : Sprite;
		
		public function PhotosHolder(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc );
			
			initialize();
		}
		
		private function initialize() : void
		{
			addBackground();
			addTitle();
		}
		
		private function addBackground() : void
		{
			r = new Sprite();
			r.graphics.beginFill(0xD40073);
			r.graphics.drawRect(0, 0, 2880, 20);
			r.graphics.endFill();
				
			(view as DisplayObjectContainer).addChild(r);
		}
		
		private function addTitle() : void
		{
			var f : TextFormat = new TextFormat("kroeger", 8, 0xffffff);
							
			t = new TextField();
			t.embedFonts = true;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.antiAliasType = AntiAliasType.NORMAL;
			t.defaultTextFormat = f;
			t.text = "";
			t.x = 50; t.y = 2;
			
			(view as DisplayObjectContainer).addChild(t);
		}
		
		public function addChild(child : Photo) : void
		{
			DisplayObjectContainer(view).addChild(child);
			addListener(child);
		}

		public function onResize(evt : ResizeEvent) : void
		{
		}

		public function photo_changed_event(evt : PhotoChangedEvent) : void
		{
			notifyChanged(evt);
			
			t.text = evt.title;
		}
	}
}
