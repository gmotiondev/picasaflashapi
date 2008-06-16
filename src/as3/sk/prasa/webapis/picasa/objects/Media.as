package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.FeedElement;	
	import sk.prasa.webapis.picasa.objects.Namespaces;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Media extends FeedElement
	{		
		private var media_ns : Namespace = Namespaces.MEDIA_NS;
		
		public function Media(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		public function get content() : MediaContent
		{
			var tMediaContent : MediaContent = new MediaContent();
				tMediaContent.url = Utils.parseString(this.data.media_ns::group.media_ns::content.@url);
				tMediaContent.type = Utils.parseString(this.data.media_ns::group.media_ns::content.@type);
				tMediaContent.medium = Utils.parseString(this.data.media_ns::group.media_ns::content.@medium);
				tMediaContent.width = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@width);
				tMediaContent.height = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@height);
				tMediaContent.fileSize = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@fileSize);
			
			return tMediaContent;
		}
		
		public function set content(aContent : MediaContent) : void
		{
			// TODO: ...
		}
		
		public function get credit() : String
		{
			return Utils.parseString(this.data.media_ns::group.media_ns::credit);
		}
		
		public function set credit(aCredit : String) : void
		{
			// TODO: ...
		}
		
		public function get description() : String
		{
			return Utils.parseString(this.data.media_ns::group.media_ns::description);
		}
		
		public function set description(aDescription : String) : void
		{
			// TODO: ...
		}
		
		public function get keywords() : Array
		{
			return this.data.media_ns::group.media_ns::keywords.split(" ").join("").split(",");
		}
		
		public function set keywords(aKeywords : Array) : void
		{
			// TODO: ...
		}
		
		public function get thumbnails() : Array
		{
			var tRes : Array = [];
			
			try
			{
				for each(var thumb : XML in this.data.media_ns::group.media_ns::thumbnail)
				{
					tRes.push(new MediaThumbnail(
						Utils.parseString(thumb.@url), 
						Utils.parseNumber(thumb.@width), 
						Utils.parseNumber(thumb.@height))); 
				}
			} catch(e : Error)
			{
				throw new Error(e);
			}
			
			return tRes;
		}
		
		public function set thumbnails(aThumbnails : Array) : void
		{
			// TODO: ..
		}
		
		public function get title() : String
		{
			return Utils.parseString(this.data.media_ns::group.media_ns::title);
		}
			
		public function set title(aTitle : String) : void
		{
			// TODO: ...
		}
		
		public function toString() : String
		{
			try
			{
				return "[Media " +
					" content=" + content.toString() + 
					", credit=" + credit + 
					", description=" + description + 
					", keywords=" + keywords.join(",") + 
					", thumbnails=" + thumbnails.join(", ") + 
					", title=" + title + 
					"]";
			} catch(e : Error)
			{
				// e.g. when parsed from photo as parent, album doesn't have media:group
				return "Error Media.toString();: " + e.message;
			}
			
			return null;
		}
	}	
}
