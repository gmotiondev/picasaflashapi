/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.organization.ui.elements.Cell;
interface sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer 
{
	function setTweenFunction(value : Function) : Void
	function setX(value : Number) : Void;
	function setY(value : Number) : Void;
	function getX() : Number;
	function getY() : Number;
	function setWidth(value : Number) : Void;
	function setHeight(value : Number) : Void;
	function getWidth() : Number;
	function getHeight() : Number;
	function setAutoAdjustLayout(value : Boolean) : Void;
	function getTarget() : MovieClip;
	function getTotalCells() : Number;
	function getCells() : Array;
	function getCellByLink(link : MovieClip) : Cell;
	function getCellIndex(cell : Cell) : Number;
	function getCellAt(index : Number) : Cell;
	function addToLayout(object : MovieClip, moveToCoordinates : Boolean, addToStage : Boolean) : Void;
	function applyItem(item : MovieClip, tweenFunction : Function) : Void;
	function apply(tweenFunction : Function) : Void;
	function addLinkAt(object : MovieClip, index : Number) : Void;
	function removeLinks() : Void;
	function removeLinkAt(index : Number) : Void;
	function removeCell(cell : Cell) : Void;
}
