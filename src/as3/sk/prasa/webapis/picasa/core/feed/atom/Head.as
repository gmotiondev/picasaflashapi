package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.FeedElement;
	import sk.prasa.webapis.picasa.core.feed.Namespaces;
	import sk.prasa.webapis.picasa.core.feed.Utils;
	import sk.prasa.webapis.picasa.core.feed.atom.IHead;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Head extends FeedElement implements IHead 
	{
		private var atom_ns : Namespace = Namespaces.ATOM_NS;

		public function Head(xmllist : XMLList)
		{
			super(xmllist);
		}

		public function get title() : Title
		{
			var tTitle : Title = new Title();
				tTitle.type = this.data.atom_ns::title.@type;	// nullCheck?	
				tTitle.value = this.data.atom_ns::title;		// nullCheck?

			return tTitle;
		}

		public function set title(aTitle : Title) : void
		{
			// TODO: ... create title node on this.data! 
		}

		public function get link() : Link
		{
			var tLink : Link = new Link();
				tLink.rel = this.data.atom_ns::link.@rel;			// nullCheck?
				tLink.type = this.data.atom_ns::link.@type;			// nullCheck?
				tLink.hreflang = this.data.atom_ns::link.@hreflang;	// nullCheck?
				tLink.href = this.data.atom_ns::link.@href;			// nullCheck?
				tLink.title = this.data.atom_ns::link.@title;		// nullCheck?
				tLink.length = this.data.atom_ns::link.@length;		// nullCheck?

			return tLink;
		}

		public function set link(aLink : Link) : void
		{
			// TODO: ... create link node on this.data! 
		}

		public function get subtitle() : SubTitle
		{
			var tSubTitle : SubTitle = new SubTitle();
				tSubTitle.type = this.data.atom_ns::subtitle.@type;	// nullCheck?
				tSubTitle.value = this.data.atom_ns::subtitle;		// nullCheck?s

			return tSubTitle;
		}

		public function set subtitle(aSubTitle : SubTitle) : void
		{
			// TODO: ... create subtitle node on this.data! 
		}

		public function get updated() : Date
		{
			return Utils.parseW3CDTF(this.data.atom_ns::updated);
		}

		public function set updated(aDate : Date) : void
		{
			// TODO: ... create updated node on this.data!
		}

		public function get id() : String
		{
			return this.data.atom_ns::id;
		}

		public function set id(aId : String) : void
		{
			// TODO: ... create id node on this.data!
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
			// TODO: ... create author nodes on this.data!
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
			// TODO: ... create contributors nodes on this.data!
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

		public function get rights() : Rights
		{
			var tRights : Rights = new Rights();
				tRights.type = this.data.atom_ns::rights.@type;
				tRights.value = this.data.atom_ns::rights;
			
			return tRights;
		}

		public function set rights(aRights : Rights) : void
		{
			// TODO: ... create rights node on this.data!
		}

		public function get generator() : Generator
		{
			var tGenerator : Generator = new Generator();
				tGenerator.uri = this.data.atom_ns::generator.@uri;
				tGenerator.version = this.data.atom_ns::generator.@version;
				tGenerator.value = this.data.atom_ns::generator;
			
			return tGenerator;
		}

		public function set generator(aGenerator : Generator) : void
		{
			// TODO: ... create generator node on this.data!
		}

		public function get icon() : String
		{
			return this.data.atom_ns::icon;
		}

		public function set icon(aIcon : String) : void
		{
			// TODO: ... create icon node on this.data!
		}

		public function get logo() : String
		{
			return this.data.atom_ns::logo;
		}

		public function set logo(aLogo : String) : void
		{
			// TODO: ... create logo node on this.data!
		}
	}
}
