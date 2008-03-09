

class be.netdust.visual.tools.Rectangle {
	
	/**
	* @method      Rectangle.draw
	* @description Draw 
	* @usage       <code>Rectangle.draw(target:MovieClip, x:Number, y:Number, w:Number, h:Number, r:Object, c:Object, alpha:Object, rot:Object, gradient:String, ratios:Object):Void;</code> 
	*
	* @param    target   (MovieClip) movieClip to draw.
	* @param    x        (Number) x position of  fill
	* @param    y        (Number) y position of  fill
	* @param    w        (Number) width of  fill
	* @param    h        (Number) height of  fill
	* @param    r        (Object) corner radius of fill :: number or object {br:#,bl:#,tl:#,tr:#}
	* @param    c        (Object) hex color of fill :: number or array [0x######,0x######]
	* @param    alpha    (Object) alpha value of fill :: number or array [0x######,0x######]
	* @param    rot      (Object) rotation of fill :: number or matrix object  {matrixType:"box",x:#,y:#,w:#,h:#,r:(#*(Math.PI/180))}
	* @param    gradient (String) type of gradient "linear" or "radial"
	* @param    ratios   (Object)(optional :: default  [0,255]) - specifies the distribution of colors :: array [#,#];
	* @param    border   (Object)(optional :: default  null) - specifies the border props :: Object {top:#, bottom:#, left:#, right:#};
	*/
	public static function draw(target:MovieClip, x:Number, y:Number, w:Number, h:Number, r, c, alpha, rot, gradient:String, rat, border:Object):Void
	{
		// mg !!!
		var rbr;
		var rbl;
		var rtl;
		var rtr;
		var alphas;
		var ratios = rat;
		var matrix;
			if (typeof r == "object") {
				rbr = r.br; //bottom right corner
				rbl = r.bl; //bottom left corner
				rtl = r.tl; //top left corner
				rtr = r.tr; //top right corner
			} else {
				rbr =  rbl = rtl = rtr = r;
			}

			// if color is an object then allow for complex fills
			if(typeof c == "object") {
				if (typeof alpha != "object")
					alphas = [alpha,alpha];
				else
					alphas = alpha;

				if (ratios == undefined)
					ratios = [ 0, 0xff ];
					
					
					

				var sh = h *.7;
				if (typeof rot != "object")
					matrix = {matrixType:"box", x:0, y:0, w:w, h:h, r:90 * 0.018};
					//{matrixType:"box", x:-sh, y:sh, w:w*2, h:h*4, r:rot * 0.0174532925199433 };
				else
					matrix = rot;
					
					
				if (gradient == "radial") 
					target.beginGradientFill( "radial", c, alphas, ratios, matrix );
				else {
					target.beginGradientFill( "linear", c, alphas, ratios, matrix );
				}

			} else if (c != undefined) {
				target.beginFill (c, alpha);
			}

			//bottom right corner
			if( border.bottom )	target.lineStyle( border.bottom.thick, border.bottom.color, border.bottom.alpha );
			else target.lineStyle(0,0,0);
			
			r = rbr;
			var a = r - (r*0.707106781186547); //radius - anchor pt;
			var s = r - (r*0.414213562373095); //radius - control pt;			
			target.moveTo ( x+w,y+h-r);
			target.lineTo ( x+w,y+h-r );
			target.curveTo( x+w,y+h-s,x+w-a,y+h-a);
			target.curveTo( x+w-s,y+h,x+w-r,y+h);

			// bottom
			//bottom left corner
			r = rbl;
			a = r - (r*0.707106781186547);
			s = r - (r*0.414213562373095);	
			if( border.bottom )	target.lineStyle( border.bottom.thick, border.bottom.color, border.bottom.alpha );
			else target.lineStyle(0,0,0);			
			target.lineTo ( x+r,y+h );
			target.curveTo( x+s,y+h,x+a,y+h-a);
			
			if( border.left ) target.lineStyle( border.left.thick, border.left.color, border.left.alpha );
			else target.lineStyle(0,0,0);			
			target.curveTo( x,y+h-s,x,y+h-r);
	
			// left
			//top left corner
			r = rtl;
			a = r - (r*0.707106781186547);
			s = r - (r*0.414213562373095);	
			if( border.left ) target.lineStyle( border.left.thick, border.left.color, border.left.alpha );
			else target.lineStyle(0,0,0);			
			target.lineTo( x,y+r );					
			target.curveTo( x,y+s,x+a,y+a);
			
			if( border.top ) target.lineStyle( border.top.thick, border.top.color, border.top.alpha );
			else target.lineStyle(0,0,0);
			target.curveTo( x+s,y,x+r,y);

			// top
			//top right corner
			r = rtr;
			a = r - (r*0.707106781186547);
			s = r - (r*0.414213562373095);
			if( border.top ) target.lineStyle( border.top.thick, border.top.color, border.top.alpha );
			else target.lineStyle(0,0,0);			
			target.lineTo ( x+w-r,y );	
			target.curveTo( x+w-s,y,x+w-a,y+a);
			
			if( border.right ) target.lineStyle( border.right.thick, border.right.color, border.right.alpha );
			else target.lineStyle(0,0,0);
			target.curveTo( x+w,y+s,x+w,y+r);
			
			// right
			if( border.right ) target.lineStyle( border.right.thick, border.right.color, border.right.alpha );
			else target.lineStyle(0,0,0);			
			target.lineTo ( x+w,y+h-r );

			if (c != undefined)
				target.endFill();
	}
}