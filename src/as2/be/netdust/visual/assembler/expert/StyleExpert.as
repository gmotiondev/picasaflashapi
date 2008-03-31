import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.ExpertList;
import be.netdust.visual.assembler.expert.ExpertLocator;
import be.netdust.visual.tools.css.CSSParser;
class be.netdust.visual.assembler.expert.StyleExpert
extends be.netdust.visual.assembler.expert.Expert
{
	
	public static function getInstance( _oOwner:IAssembler ) : StyleExpert 
	{
		if( !ExpertLocator.getInstance( _oOwner ).isRegistered(  ExpertList.STYLE_EXPERT ) )
		{
			var _oInstance:StyleExpert = new StyleExpert( _oOwner );
		};		
		return StyleExpert( ExpertLocator.getInstance( _oOwner ).locate( ExpertList.STYLE_EXPERT ) );
	};
	
	private function StyleExpert( _oOwner:IAssembler )
	{
		super( ExpertList.STYLE_EXPERT, _oOwner );		
	}
	
	/**
	* build style theme from <style></style> content
	* @param	_style
	*/
	public function buildStyle( _style:String ) {
		var _oCSS:CSSParser = new CSSParser( _style );
		_oCSS.resolve(  );		
	}
	
	/**
	* build style theme from attribute content
	* @param	_style
	*/
	public function buildStyleProperty( instance, _style:String ) {
		var _oCSS:CSSParser = new CSSParser( _style );
		_oCSS.resolve( instance.getStyle() );
	}

}