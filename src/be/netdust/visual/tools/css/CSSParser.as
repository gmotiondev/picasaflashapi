/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.tools.Tokenizer;

/**
* todo
* 
* 1: faster parsing if possible
* 2: solve problems with inheritance from parent styles
* 
*/
class be.netdust.visual.tools.css.CSSParser 
extends Tokenizer {
	
	public var scope:Object = null;
	
	public function CSSParser( src:String ) {
		super(src, false);
	}
	
	public function toString() : String
	{
		return "CSSParser instance"
	}
	
	public function resolve( _scope:Object ) {
        cnt = -1;
				
        scope = _scope?_scope:{};		
        var _tok:Array = getToken();
		
        while (_tok) {
            switch (_tok[0]) {                
				case WORD : 
					if( !(scope instanceof Style) )
						 _parseword(_tok);
					else _parsestyle(_tok, scope)
                    break;
            }
            if (errors.length > 0) {
                break;
            }
            _tok = getToken();
        }
	};
	
	private function _parseword( t:Array ) {
		
		var _end:Number = _findNext( CURLYBR0 );
			
		if( t[0] == WORD && t[1].indexOf(".") != -1  )
		{
			// parse pseudo-classes source for this style
			var _oParent = Style.getStyle( t[1].split(".")[0] );
			var _style:String = t[1].split(".")[1];

			if( _oParent.getSubStyle(_style) == undefined ) 
			{
				scope[ _oParent._sID+"."+_style ] = _oParent._substyles[_style] = Style.cloneStyle( _oParent );
				scope[ _oParent._sID+"."+_style ]._sID = _style;
			} else scope[ _oParent._sID+"."+_style ] = _oParent.getSubStyle(_style);
			var _scope:Style = scope[ _oParent._sID+"."+_style ];
		}
		else if( t[0] == WORD ) 
		{
			// parse style source
			if( Style.getStyle( t[1] ) == undefined ) {
				scope[t[1]] = Style.newStyle(t[1]);
			}	
			else scope[t[1]] = Style.getStyle( t[1] );
			var _scope:Style = scope[t[1]];
		}
		
		while( cnt < _end ) {
			
			var _aTok:Array = getToken();
			if (_aTok[0] ==  CURLYBR1 ) _aTok = getToken();
			else if (_aTok[0] ==  CURLYBR0 ) return;


			if( _aTok[0] == COLON && source[cnt+1][0] == WORD  )
			{		
				// parse dynamic state source for this style
				var _oParent = Style.getStyle( source[cnt-1][1] );
				if( _oParent == undefined ) _oParent = scope[source[cnt-1][1]];

				var _aTok:Array = getToken();			

				if( _oParent.getSubStyle(_aTok[1]) == undefined ) 
				{
					   scope[ _oParent._sID+":"+_aTok[1] ] = _oParent.subStyle( _aTok[1], true );
				} else scope[ _oParent._sID+":"+_aTok[1] ] = _oParent.getSubStyle( _aTok[1] );
				
				cnt++;
				var _scope:Style = scope[ _oParent._sID+":"+_aTok[1] ];
				var _aTok:Array = getToken();	
			}
			
			// parse		
			_parsestyle( _aTok, _scope );
		}
	}
	
	private function _parsestyle( _aTok:Array, _scope )
	{
		if( _aTok[1] == "font" ) _font( _scope )
		else if( _aTok[1] == "text" ) _text( _scope )
		else if( _aTok[1] == "color" ) _color( _scope )			
		else if( _aTok[1] == "border" ) _border( _scope )
		else if( _aTok[1] == "margin" ) _margin( _scope )
		else if( _aTok[1] == "padding" ) _padding( _scope )
		else if( _aTok[1] == "background" ) _background( _scope )
		else if( _aTok[0] == WORD ){
			_scope[_aTok[1]] = source[cnt+2][1];
		}
	}
	
	/**
	* sets the font, size, italic and bold properties of a text
	* @param	style
	*/
	private function _font( style:Object )
	{
		if( style.getFormat("fu") == undefined ) style.setFormat("fu", {} );
		
		var _aTok:Array = getToken();
		var _end:Number = _findNext( END );

		if( _aTok[0] == COLON ) {
			_aTok = getToken();
			var ind:Number = _end;

			style.getFormat("fu")[ "font" ] = source[--ind][1];
			if(source[--ind][1] == WORD )--ind;
			style.getFormat("fu")[ "size" ] = source[--ind][1];
			style.getFormat("fu")[ "italic" ] = source[--ind][1] =="italic" ? true:false;
			style.getFormat("fu")[ "bold" ] = source[--ind][1] =="bold" ? true:false;
		} 
		else 
		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();	

			if( _aTok[1] == "family" ) {
				style.getFormat("fu")[ "font" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "size" ) {
				style.getFormat("fu")[ "size" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "style" ) {
				style.getFormat("fu")[ "italic" ] = source[cnt+2][1] =="italic" ? true:false;
			}
			else
			if( _aTok[1] == "weight" ) {
				style.getFormat("fu")[ "bold" ] = source[cnt+2][1] =="bold" ? true:false;
			}
		}

		cnt = _end;
	}
	
	/**
	* sets the align, decoration and indent properties of a text
	* @param	style
	*/
	private function _text( style:Object ) 
	{
		if( style.getFormat("fu") == undefined ) style.setFormat("fu", {} );
		
		var _aTok:Array = getToken();
		var _end:Number = _findNext( END );

		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();			
			if( _aTok[1] == "align" ) {
				style.getFormat("fu")[ "align" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "indent" ) {
				style.getFormat("fu")[ "indent" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "decoration" ) {
				style.getFormat("fu")[ "underline" ] = source[cnt+2][1]=="underline" ? true:false;
			}			
		}

		cnt = _end;
	}
	
	
	/**
	* sets the color of text
	* @param	style
	*/
	private function _color( style:Object ) 
	{
		if( style.getFormat("fu") == undefined ) style.setFormat("fu", {} );
		
		var _aTok:Array = source[cnt+2];
		var _end:Number = _findNext( END );	

		style.getFormat("fu")["color"] = _aTok[1];
		
		cnt = _end;
	}
	
	/**
	* sets the margin of a box
	* @param	style
	*/
	private function _margin( style:Object ) {
		var _aTok:Array = getToken();
		
		if( _aTok[0] == COLON ) {
			var _end:Number = _findNext( END );
			_aTok = getToken();

			if( _end-1 == cnt || ( _end-2 == cnt && source[_end-1][0] == WORD ) ) {
				style["marginLeft"] = _aTok[1];
				style["marginRight"] = _aTok[1];
				style["marginTop"] = _aTok[1];
				style["marginBottom"] = _aTok[1];
				
			}
			else if( _end-2 == cnt || ( _end < cnt + 4 ) ) {				
				style["marginTop"] = style["marginBottom"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["marginLeft"] = style["marginRight"] = _aTok[1];
			}
			else {
				style["marginTop"] = _aTok[1];
				_aTok = getToken();	
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["marginRight"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["marginBottom"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["marginLeft"] = _aTok[1];	
			}
		}
		else
		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();
			style[ "margin" + _aTok[1].substr(0,1).toUpperCase + _aTok[1].substr(1,5) ] = source[cnt+2][1];
		}
		else {
			errors.push( "css syntax error")
		}

		cnt = _end;
	}
	
	/**
	* sets the padding of a box
	* @param	style
	*/
	private function _padding( style:Object ) {
		var _aTok:Array = getToken();
		var _end:Number = _findNext( END );
		
		
		if( _aTok[0] == COLON ) {
			
			_aTok = getToken();
			
			if( _end-1 == cnt || ( _end-2 == cnt && source[_end-1][0] == WORD ) ) {
				style["paddingLeft"] = _aTok[1];
				style["paddingRight"] = _aTok[1];
				style["paddingTop"] = _aTok[1];
				style["paddingBottom"] = _aTok[1];
			}
			else if( _end-2 == cnt || ( _end < cnt + 4 ) ) {				
				style["paddingTop"] = style["paddingBottom"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["paddingLeft"] = style["paddingRight"] = _aTok[1];
			}
			else {				
				style["paddingTop"] = _aTok[1];
				_aTok = getToken();	
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["paddingRight"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["paddingBottom"] = _aTok[1];
				_aTok = getToken();				
				if( _aTok[0] == WORD ) _aTok = getToken();
				style["paddingLeft"] = _aTok[1];	
			}
		}
		else
		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();
			style[ "padding" + _aTok[1].substr(0,1).toUpperCase + _aTok[1].substr(1,5) ] = source[cnt+2][1];
		}
		else {
			errors.push( "css syntax error")
		}
		
		cnt = _end;
	}
	
	/**
	* sets the border properties of a box
	* 
	* possible props : thick, color, alpha
	* @param	style
	*/
	private function _border( style:Object ) {
		var _aTok:Array = getToken();
		var _end:Number = _findNext( END );
		
		if( _aTok[0] == COLON ) {
			_aTok = getToken();
			style[ "borderTopWidth" ] = style[ "borderBottomWidth" ] = _aTok[1];
			style[ "borderLeftWidth" ] = style[ "borderRightWidth" ] = _aTok[1];
			_aTok = getToken();
			
			if(_aTok[0] == WORD ) _aTok = getToken();
			if( cnt<_end ) {
				   style[ "borderTopColor" ] =  style[ "borderBottomColor" ] = _aTok[1];
				   style[ "borderLeftColor" ] =  style[ "borderRightColor" ] = _aTok[1];
			} else style[ "borderTopColor" ] =  style[ "borderBottomColor" ] =  style[ "borderLeftColor" ] =  style[ "borderRightColor" ] = 0;
			
			_aTok = getToken();
			if( cnt<_end ) {
				   style[ "borderTopAlpha" ] =  style[ "borderBottomAlpha" ] = _aTok[1];
				   style[ "borderLeftAlpha" ] =  style[ "borderRightAlpha" ] = _aTok[1];
			} else style[ "borderTopAlpha" ] =  style[ "borderBottomAlpha" ] =  style[ "borderLeftAlpha" ] =  style[ "borderRightAlpha" ] = 100;
			
		}
		else	
		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();		
			if( _aTok[1] == "width" ) {
				style[ "borderTopWidth" ] = style[ "borderBottomWidth" ] = style[ "borderLeftWidth" ] = style[ "borderRightWidth" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "color" ) {
				style[ "borderTopColor" ] =  style[ "borderBottomColor" ] =  style[ "borderLeftColor" ] =  style[ "borderRightColor" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "alpha" ) {
				style[ "borderTopAlpha" ] =  style[ "borderBottomAlpha" ] =  style[ "borderLeftAlpha" ] =  style[ "borderRightAlpha" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "bottom" ) {
				_aTok = getToken();
				if( _aTok[0] == COLON ) _getBorderValues( style, "borderBottom" );
				else 
				if( _aTok[0] == OP_PLUS ) {
					_aTok = getToken();
					if( _aTok[1] == "width" ) {
						style[ "borderBottomWidth" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "color" ) {
						style[ "borderBottomColor" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "alpha" ) {
						style[ "borderBottomAlpha" ] = source[cnt+2][1];
					}
				}
			}
			else
			if( _aTok[1] == "right" ) {
				_aTok = getToken();
				if( _aTok[0] == COLON ) _getBorderValues( style, "borderRight" );
				else 
				if( _aTok[0] == OP_PLUS ) {
					_aTok = getToken();
					if( _aTok[1] == "width" ) {
						style[ "borderRightWidth" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "color" ) {
						style[ "borderRightColor" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "alpha" ) {
						style[ "borderRightAlpha" ] = source[cnt+2][1];
					}
				}
			}
			else
			if( _aTok[1] == "top" ) {
				_aTok = getToken();		
				if( _aTok[0] == COLON ) _getBorderValues( style, "borderTop" );
				else 
				if( _aTok[0] == OP_PLUS ) {
					_aTok = getToken();
					if( _aTok[1] == "width" ) {
						style[ "borderTopWidth" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "color" ) {
						style[ "borderTopColor" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "alpha" ) {
						style[ "borderTopAlpha" ] = source[cnt+2][1];
					}
				}
			}
			else
			if( _aTok[1] == "left" ) {
				_aTok = getToken();
				if( _aTok[0] == COLON ) _getBorderValues( style, "borderLeft" );
				else 
				if( _aTok[0] == OP_PLUS ) {
					_aTok = getToken();
					if( _aTok[1] == "width" ) {
						style[ "borderLeftWidth" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "color" ) {
						style[ "borderLeftColor" ] = source[cnt+2][1];
					}
					else
					if( _aTok[1] == "alpha" ) {
						style[ "borderLeftAlpha" ] = source[cnt+2][1];
					}
				}
			}
		}
		else {
			errors.push( "css syntax error")
		}
		
		cnt = _end;
	}
	
	private function _getBorderValues( style, cssProp:String )
	{
		var _end:Number = _findNext( END );
		
		var _aTok:Array = getToken();
		style[ cssProp + "Width" ] = _aTok[1];
		_aTok = getToken();
					
		if(_aTok[0] == WORD ) _aTok = getToken();
		if( cnt<_end ) {
			style[ cssProp + "Color" ] = _aTok[1];
		} else style[ cssProp + "Color" ] = 0;
					
		_aTok = getToken();
		if( cnt<_end ) {
			style[ cssProp + "Alpha" ] = _aTok[1];
		} 
		else style[ cssProp + "Alpha" ]= 100;
	}
	
	/**
	* sets the background properties of an element
	* 
	* possible props : color, image, corner, position, alpha
	* @param	style
	*/
	private function _background( style:Object ) {
		var _aTok:Array = getToken();
		var _end:Number = _findNext( END );

		if( _aTok[0] == COLON ) {
			_aTok = getToken();
			var ind:Number = _end;
			// TODO: shorthand background props
		} 
		else 		
		if( _aTok[0] == OP_PLUS ) {
			_aTok = getToken();
			if( _aTok[1] == "alpha" ) {
				style[ "backgroundAlpha" ] = source[cnt+2][1];
			}
			else
			if( _aTok[1] == "image" ) {
				_aTok = getToken();		
				if( _aTok[1] == "url" ) {
					_aTok = source[cnt+2];
					style["backgroundImage"] = _aTok[1];
				}
				else {
					style["backgroundSkin"] = _aTok[1];
				}
			}
			else
			if( _aTok[1] == "corner" ) {
				_backgroundCorner( style, getToken(), _end );
			}
			else
			if( _aTok[1] == "color" ) {
				_aTok = source[cnt+2];
				style["backgroundColor"] = _aTok[1];
			}
			else
			if( _aTok[1] == "position" ) {
				if( style[ "backgroundPosition" ] == undefined ) style[ "backgroundPosition" ] = {}
				_aTok = source[cnt+2];
				style[ "backgroundPosition" ].x =_aTok[1];
				_aTok = source[cnt+3];	
				if( _aTok[0] == WORD ) _aTok = source[cnt+4];
				style[ "backgroundPosition" ].y =_aTok[1];
			}
		}
		
		cnt = _end;
	}

	
	private function _backgroundCorner( style:Object, _aTok:Array, _end:Number ) {
		_aTok = getToken();
		if( _end-1 == cnt || ( _end-2 == cnt && source[_end-1][0] == WORD ) ) {
			style["cornerTopLeft"] = _aTok[1];
			style["cornerTopRight"] = _aTok[1];
			style["cornerBottomLeft"] = _aTok[1];
			style["cornerBottomRight"] = _aTok[1];
		}
		else if( _end-2 == cnt || ( _end < cnt + 4 ) ) {	
			style["cornerTopLeft"] = style["cornerTopRight"] = _aTok[1];
			_aTok = getToken();				
			if( _aTok[0] == WORD ) _aTok = getToken();
			style["cornerBottomLeft"] = style["cornerBottomRight"] = _aTok[1];
		}
		else {
			style["cornerTopLeft"] = _aTok[1];
			_aTok = getToken();	
			if( _aTok[0] == WORD ) _aTok = getToken();
			style["cornerTopRight"] = _aTok[1];
			_aTok = getToken();				
			if( _aTok[0] == WORD ) _aTok = getToken();
			style["cornerBottomLeft"] = _aTok[1];
			_aTok = getToken();				
			if( _aTok[0] == WORD ) _aTok = getToken();
			style["cornerBottomRight"] = _aTok[1];	
		}		
	}
	

	
	private var errors:Array= [];
}