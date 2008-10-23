package vo 
{
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;				
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public dynamic class Photos extends Array
	{
		private var __current : Number;
		
		public function getNext() : String
		{
			if(++__current >= this.length || isNaN(__current)) __current = 0;
			
			return (this[__current] as PhotoEntry).gphoto.id;
		}
		 
		public function getPrevious() : String
		{
			if(--__current < 0 || isNaN(__current)) __current = this.length - 1;
			
			return (this[__current] as PhotoEntry).gphoto.id;
		}
		
		public function getCurrentTitle() : String
		{
			return (this[__current] as PhotoEntry).summary;
		}
		
		public function getCurrentId() : String
		{
			return getCurrent();
		}
		
		public function getCurrentUrl() : String
		{
			return (this[__current] as PhotoEntry).media.content.url;
		}

		public function getCurrent() : String
		{
			return (this[__current] as PhotoEntry).gphoto.id;
		}

		public function setCurrent(aId : String) : String
		{
			__current = getIndexById(aId);
			
			return aId;
		}
		 
		private function getIndexById(aId : String) : Number
		{
			for(var a : Number = 0; a < this.length; a++)
			{
				if((this[a] as PhotoEntry).gphoto.id == aId) return a;
			}
			
			return 0;
		}
	}
}
