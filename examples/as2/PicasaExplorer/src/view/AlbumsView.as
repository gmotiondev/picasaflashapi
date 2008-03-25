/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.collections.Map;
import com.bourre.data.iterator.ObjectIterator;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.Album;
import sk.prasa.webapis.picasa.Photo;

import mx.controls.Tree;
import mx.controls.DataGrid;
import mx.controls.Button;

import control.ChangeEvent;
import control.PhotosGetEvent;

class view.AlbumsView extends MovieClipHelper 
{
	private var tree:Tree;
	private var dg:DataGrid;
	private var albums:Map = new Map();
	
	
	public function AlbumsView(name:String, mc:MovieClip)
	{
		super(name, mc);
		initialize();
	}
	
	private function initialize():Void
	{
		dg = view.createClassObject(DataGrid, "dg_mc", 5, {columnNames:["Property", "Value"]});
		dg.move(330, 0);
		dg.setSize(480, 320);
		dg.hScrollPolicy = "on";

		
		tree = view.createClassObject(Tree,"tree_mc", 6);
		tree.setSize(320, 320);
		tree.addEventListener("nodeOpen", Delegate.create(this, onNodeOpen));
		tree.addEventListener("change", Delegate.create(this, onTreeChange));
		
		//var bt:Button = view.createClassObject(Button,"button2", 7, {label:"Test Button"});
		//	bt.label = "test!";
	}
	
	public function change(e:ChangeEvent):Void
	{
		switch(e.property)
		{
			case "albums":
				for(var a:Number = 0; a < e.data.length; a++)
				{
					var tItem:Album = e.data[a];
					albums.put(tItem.gphoto.id, {a:tItem,p:new Map()});
				}
				
				refreshTree();
				break;
				
			case "photos":
				var tChangeForAlbum:String = e.data[0].album.gphoto.id;
	
				for(var a:Number = 0; a < e.data.length; a++)
				{
					var tPhoto:Photo = e.data[a];
					albums.get(tChangeForAlbum).p.put(tPhoto.gphoto.id, tPhoto);
				}
				
				refreshTree();
				
				break;
			default:break;
		}
	}
	
	private function refreshTree():Void
	{
		tree.removeAll();
		
		var tAIterator:ObjectIterator = albums.getKeysIterator();
		
		while(tAIterator.hasNext())
		{
			var tItem:Object = albums.get(tAIterator.next());
			var tNode = tree.addTreeNode(tItem.a.title+" ("+tItem.a.gphoto.numphotos+")", tItem.a.gphoto.id);

			var tPIterator:ObjectIterator = tItem.p.getKeysIterator();
			
			while(tPIterator.hasNext())
			{
				var tParentNode:XML = tree.getTreeNodeAt(getNodeIndex(tItem.a.gphoto.id));
				var tPItem:Object = tItem.p.get(tPIterator.next());
				
				tParentNode.addTreeNode(tPItem.title, tPItem.gphoto.id);
			}
			
			tree.setIsBranch(tNode, true);
		
			if(tItem.p.getSize() > 0)
			{
				tree.setIsOpen(tNode,true);
			}
		}
	}
	
	private function getNodeIndex(aId:String):Number
	{
		for(var a:Number = 0; a < tree.length; a++)
		{
			if(tree.getTreeNodeAt(a).attributes.data == aId) return a;
		}
		
		return -1;
	}
	
	private function onNodeOpen(event:Object):Void
	{
		var tAlbumid:String = event.node.attributes.data;
		
		EventBroadcaster.getInstance().dispatchEvent(new PhotosGetEvent("picasaflashapi",tAlbumid));
	}
	
	private function onTreeChange(event:Object)
	{
		//trace("got change from: "++" is branch "+tree.getIsBranch(tree.selectedNode));
		var tID:String = tree.selectedNode.attributes.data;
		var tDP = [];
		var tItem:Object;
		
		if(tree.getIsBranch(tree.selectedNode))
		{
			tItem = albums.get(tID).a;
		} else
		{
			tItem = albums.get(findParent(tID)).p.get(tID);
		}
		
		for(var tKey in tItem) {
			tDP.push({key:tKey, value:tItem[tKey].toString(),dummy:""});
		}
		
		dg.dataProvider = tDP;
	}
	
	private function findParent(aID:String):String
	{
		var tAIterator:ObjectIterator = albums.getKeysIterator();
		
		while(tAIterator.hasNext())
		{
			var tItemID:String = tAIterator.next();
			var tItem = albums.get(tItemID); 
			if(tItem.p.containsKey(aID)) return tItemID; 
		}
		
		return null;
	}
}