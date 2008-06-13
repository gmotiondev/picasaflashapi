package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.Utils;	
	import sk.prasa.webapis.picasa.core.feed.Namespaces;	
	import sk.prasa.webapis.picasa.core.feed.FeedElement;
	import sk.prasa.webapis.picasa.core.feed.atom.IEntry;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Entry extends FeedElement implements IEntry 
	{
		private var atom_ns : Namespace = Namespaces.ATOM_NS;
		private var xhtml_ns : Namespace = Namespaces.XHTML_NS;

		public function Entry(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		public function get title() : String
		{
			return this.data.atom_ns::title;
		}
		
		public function set title(aTitle : String) : void
		{
			// TODO: ...
		}
		
		public function get links() : Array
		{
			var tLinks : Array = new Array();
			
			for each(var node : XML in this.data.atom_ns::link)
			{
				var tLink : Link = new Link();
				tLink.rel = node.@rel;
				tLink.type = node.@type;
				tLink.hreflang = node.@hreflang;
				tLink.href = node.@href;
				tLink.title = node.@title;
				tLink.length = node.@["length"];
				
				tLinks.push(tLink);
			}
			
			return tLinks;
		}
		
		public function set links(aLinks : Array) : void
		{
			// TODO: ...
		}
		
		public function get published() : Date
		{
			return Utils.parseW3CDTF(this.data.atom_ns::published);
		}
		
		public function set published(aDate : Date) : void
		{
			// TODO: ...
		}
		
		public function get authors() : Array
		{
			var tAuthors : Array = new Array();
			
			for each(var node : XML in this.data.atom_ns::author)
			{
				var tAuthor : Author = new Author();
					tAuthor.name = node.atom_ns::["name"];
					tAuthor.email = node.atom_ns::email;
					tAuthor.uri = node.atom_ns::uri;
					
				tAuthors.push(tAuthor);
			}
			
			return tAuthors;
		}

		public function set authors(aAuthors : Array) : void
		{
			// TODO: ... 
		}
		
		public function get contributors() : Array
		{
			var tContributors : Array = new Array();
			
			for each(var node : XML in this.data.atom_ns::contributor)
			{
				var tContributor : Contributor = new Contributor();
					tContributor.name = node.atom_ns::["name"];
					tContributor.email = node.atom_ns::email;
					tContributor.uri = node.atom_ns::uri;
					
				tContributors.push(tContributor);
			}
			
			return tContributors;
		}

		public function set contributors(aContributors : Array) : void
		{
			// TODO: ... 
		}
		
		public function get content() : Content
		{
			var tContent : Content = new Content();
				tContent.type = this.data.atom_ns::content.@type;
				tContent.src = this.data.atom_ns::content.@src;
			
			if(tContent.type = TextNode.TYPE_XHTML)
			{
				tContent.value = this.data.atom_ns::content.xhtml_ns::div;
			} else
			{
				tContent.value = this.data.atom_ns::content;
			}
			
			return tContent;
		}
		
		public function set content(aContent : Content) : void
		{
			// TODO: ...
		}
		
		public function get categories() : Array
		{
			var tCategories : Array = new Array();
			
			for each(var node : XML in this.data.atom_ns::category)
			{
				var tCategory : Category = new Category();
					tCategory.term = node.@term;
					tCategory.scheme = node.@scheme;
					tCategory.label = node.@label;
					
				tCategories.push(tCategory);
			}
			
			return tCategories;
		}

		public function set categories(aCategories : Array) : void
		{
			// TODO: ... create categories nodes on this.data!
		}
		
		public function get id() : String
		{
			return this.data.atom_ns::id;
		}
		
		public function set id(aId : String) : void
		{
			// TODO: ...
		}
		
		public function get updated() : Date
		{
			return Utils.parseW3CDTF(this.data.atom_ns::updated);
		}

		public function set updated(aDate : Date) : void
		{
			// TODO: ... 
		}
		
		public function get summary() : String
		{
			return this.data.atom_ns::summary;
		}
		
		public function set summary(aSummary : String) : void
		{
			// TODO: ...
		}
		
//		public function get source() : Head
//		{
//			return new Head(XMLList(this.data.atom_ns::source));
//		} 
	}
}
