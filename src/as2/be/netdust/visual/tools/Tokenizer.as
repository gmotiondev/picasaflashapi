/**
* Tokenizer Class
* @author Stefan Vandermeulen -- stefan@netdust.be
* @version 1.0
*/

class be.netdust.visual.tools.Tokenizer {

	public var source:Array;
	
	
	public function Tokenizer( src, nolex:Boolean ){
		source =[];
		read(src, nolex);
	}
	
	public function read(src, nolex) {
		cnt = 0;
		if (!nolex) {            
            if( !parse( _trim( src ) ) ) {
				trace("script parsed");
			};
        } else {
            source =  src;
        }
	}
	
	private function parse(_str:String):Boolean {
        cnt = 0;
        _string = _str;
	
        while (cnt < _string.length) {
            if (!parsetoken()) {
                return (false);
            }
        }
        return (true);
    }
    
	private function parsetoken() {
		
        var _nChar:Number = _string.charCodeAt(cnt);
        while ((_nChar < 33) || (_nChar > 125)) {
            cnt++;
            if (cnt > _string.length) {
                return (true);
            }
            _nChar = _string.charCodeAt(cnt);
        }

		// get color
		if (( (_nChar == 48) && _string.charAt(cnt+ 1) == "x" ) || _string.charAt(cnt) == "#" ){
			if( _nChar!= 48 ) {
				source.push( [VALUE, parseInt( _string.substr( cnt+1, 6 ), 16 ), COLOR]);
			}
			else {
				cnt++;
				source.push( [VALUE, parseInt( _string.substr( cnt+2, 5 ), 16 ), COLOR]);
			}
			
			cnt =  cnt + 7;
			return (true);
		};
		
		// get numbers
        if ((_nChar > 47) && (_nChar < 58)) {			
            var _sChar:String = "";
            while ((_nChar > 47) && (_nChar < 58)) {
                _sChar = _sChar + _string.charAt(cnt);
                cnt++;
                _nChar = _string.charCodeAt(cnt);
            }

            if (_string.charAt(cnt) != "."  ) {
                source.push([VALUE, Number (_sChar), INT]);
                return (true);
            }
            cnt++;			
            _nChar = _string.charCodeAt(cnt);
            _sChar = _sChar + ".";
            while ((_nChar > 47) && (_nChar < 58)) {
                _sChar = _sChar + _string.charAt(cnt);
                cnt++;
                _nChar = _string.charCodeAt(cnt);
            }
            source.push([VALUE, Number (_sChar), REAL]);
            return (true);
        }
		
        if (_string.substr(cnt, 4) == "true") {
            cnt = cnt + 4;
            source.push([INT, 1]);
            return (true);
        }
        if (_string.substr(cnt, 5) == "false") {
            cnt = cnt + 5;
            source.push([INT, 0]);
            return (true);
        }
        if (_string.substr(cnt, 7) == "else if") {
            cnt = cnt + 7;
            source.push([ELSEIF]);
            return (true);
        }
		
        var _sstr:String = _string.substr(cnt, 2);
        if ((((_nChar == 95) || ((_nChar == 38) && (_sstr != "&&"))) || ((_nChar > 64) && (_nChar < 91))) || ((_nChar > 96) && (_nChar < 123))) {
            var _sChar = _string.charAt(cnt);
            cnt++;
            _nChar = _string.charCodeAt(cnt);
            var _bbracket:Boolean = false;
            while ((((((((((_nChar > 64) && (_nChar < 91)) || ((_nChar > 47) && (_nChar < 58))) || ((_nChar > 96) && (_nChar < 123))) || (_nChar == 38)) || (_nChar == 46)) || (_nChar == 91)) || (_nChar == 93)) || (_nChar == 95)) || (_bbracket && ((_nChar == 39) || (_nChar == 34)))) {
                if (_nChar == 91) {
                    _bbracket = true;
                }
                if (_nChar == 93) {
                    _bbracket = false;
                }
                _sChar = _sChar + _string.charAt(cnt);
                cnt++;
                _nChar = _string.charCodeAt(cnt);
            }
            source.push([(CD["_" + _sChar] ? (CD["_" + _sChar]) : (WORD)), _sChar]);
            return (true);
        }
        if ((_nChar == 34) || (_nChar == 39)) {
            cnt++;
            var _nCharTemp:Number = _nChar;
            var _sChar:String = "";
            _nChar = _string.charCodeAt(cnt);
            while ((_nChar != _nCharTemp) && (_string.charAt(cnt - 1) != "\\")) {
                _sChar = _sChar + _string.charAt(cnt);
                cnt++;
                _nChar = _string.charCodeAt(cnt);
            }
            source.push([STR, _sChar]);
            cnt++;
            return (true);
        }
        if ((_sstr == "//") || (_sstr == "/*")) {
            if (_sstr == "//") {
                cnt = _string.indexOf(String.fromCharCode(13), cnt) + 1;
            } else if (_sstr == "/*") {
                cnt = _string.indexOf("*/", cnt) + 2;
            }
            return (true);
        }
        if ((((_sstr == ">=") || (_sstr == "<=")) || (_sstr == "==")) || (_sstr == "!=")) {
            source.push([OP_CMP, _sstr]);
            cnt = cnt + 2;
            return (true);
        }
        if ((_nChar == 60) || (_nChar == 62)) {
            source.push([OP_CMP, _string.charAt(cnt)]);
            cnt++;
            return (true);
        }
        if (_nChar == 61) {
            source.push([ASSIGN, "="]);
            cnt++;
            return (true);
        }
        if ((((_sstr == "+=") || (_sstr == "-=")) || (_sstr == "*=")) || (_sstr == "/=")) {
            source.push([ASSIGN, _sstr]);
            cnt = cnt + 2;
            return (true);
        }
        if ((_sstr == "++") || (_sstr == "--")) {
            source.push([OP_PFIX, _sstr]);
            cnt = cnt + 2;
            return (true);
        }
        if ((_nChar == 42) || (_nChar == 47)) {
            source.push([OP_MULTI, _string.charAt(cnt)]);
            cnt++;
            return (true);
        }
        if (_sstr == "&&") {
            source.push([OP_BOOL_AND, _sstr]);
            cnt = cnt + 2;
            return (true);
        }
        if (_sstr == "||") {
            source.push([OP_BOOL_OR, _sstr]);
            cnt = cnt + 2;
            return (true);
        }
        if ((_nChar == 38) || (_nChar == 94)) {
            source.push([OP_BIT, _string.charAt(cnt)]);
            cnt++;
            return (true);
        }
        var _nCharId:Number = -1;
        switch (_string.charAt(cnt)) {
            case "+" : 
                _nCharId = OP_PLUS;
                break;
            case "-" : 
                _nCharId = OP_PLUS;
                break;
            case ";" : 
                _nCharId = END;
                break;
            case "!" : 
                _nCharId = OP_UNARY;
                break;
            case "~" : 
                _nCharId = OP_UNARY;
                break;
            case "(" : 
                _nCharId = BRACE1;
                break;
            case ")" : 
                _nCharId = BRACE0;
                break;
            case "[" : 
                _nCharId = SQBRCKT1;
                break;
            case "]" : 
                _nCharId = SQBRCKT0;
                break;
            case "{" : 
                _nCharId = CURLYBR1;
                break;
            case "}" : 
                _nCharId = CURLYBR0;
                break;
            case "," : 
                _nCharId = COMMA;
                break;
            case "?" : 
                _nCharId = QESTMARK;
                break;
            case ":" : 
                _nCharId = COLON;
                break;
			case "#" : 
                _nCharId = CROSS;
                break;
        }
        if (_nCharId > 0) {
            source.push([_nCharId, _string.charAt(cnt)]);
            cnt++;
            return (true);
        };
		
        cnt++;
        return (false);
    }
    
	private function getToken() {
		cnt++
		return source[cnt];
	}
	
    private function _findNext( _nTokenID:Number ) : Number {
        var current:Number = cnt;
        if (source[current][0] == _nTokenID) {
            if (current == source.length) {
                return (current);
            } else {
                current++;
            }
        }
        while (current < source.length) {
            if (source[current][0] == _nTokenID) {
                return (current);
            }
            current++;
        }
    };

    private function _findNextOR( _atokens:Array ) : Number {
        var current = cnt;
        while (current < source.length) {
            for (var p:String in _atokens) {
                if (source[current][0] == _atokens[p]) {
                    return (current);
                };
            }
            current++;
        }
    };
	
    private function _findPriority( _ntstart:Number, _ntend:Number) : Number {
        var _ntokenID:Number = source[_ntstart][0];        
        var _nnext:Number  = _ntstart + 1;
		var _ninde:Number  = _ntstart;
        while (_nnext < _ntend) {
            if (source[_nnext][0] > _ntokenID) {
                _ntokenID = source[_nnext][0];
                _ninde = _nnext;
            }
            _nnext++;
        }
        return (_ninde);
    };
	
    private function _match( _tokID:Number, __tokID:Number) : Number  {
        var _tok:Number = 0;
        var _index:Number = cnt + 1;
		
        while (source[_index]) {
            if (source[_index][0] == _tokID) {
                _tok++;
            } else if (source[_index][0] == __tokID) {
                _tok--;
                if (_tok == 0) {
                    return (_index);
                }
            }
            _index++;
        }
        return (-1);
    };
	
    
	private function _trim( _sstr : String ) : String {
		var beg = 0, end = String(_sstr).length-1;				
		while (!isNaN(" "+_sstr.charAt(beg)+" 0") ) beg++;
		while (!isNaN(" "+_sstr.charAt(end)+" 0") ) end--;	
		return _sstr.slice(beg, end+1);
	}
	
	
    
	private var RT:Number = 1;
    private var OP_PFIX:Number = 2;
    private var FOREACH:Number = 3;
    private var OP_UNARY:Number = 4;
    private var QESTMARK:Number = 5;
    private var VALUE:Number = 6;
    private var ELSE:Number = 7;
    private var FOR:Number = 8;
    private var ASSIGN:Number = 9;
    private var ERROR:Number = 10;
    private var OP_BOOL_OR:Number = 11;
    private var MATH:Number = 12;
    private var WHILE:Number = 13;
    private var BREAK:Number = 14;
    private var INT:Number = 15;
    private var FCALL:Number = 16;
    private var OP_BIT:Number = 17;
    private var SWITCH:Number = 18;
    private var WORD:Number = 19;
    private var CMP:Number = 20;
    private var VAR:Number = 21;
    private var COLON:Number = 22;
    private var DO:Number = 23;
    private var COMMENT:Number = 24;
    private var BOOL:Number = 25;
    private var OP_BOOL_AND:Number = 26;
    private var OP_PLUS:Number = 27;
    private var PRINT:Number = 28;
    private var REAL:Number = 29;
    private var OP_MULTI:Number = 30;
    private var BRACE0:Number = 31;
    private var ELSEIF:Number = 32;
    private var BRACE1:Number = 33;
    private var CURLYBR0:Number = 34;
    private var CURLYBR1:Number = 35;
    private var COMMA:Number = 36;
    private var END:Number = 37;
    private var FUNCDEF:Number = 38;
    private var SQBRCKT0:Number = 39;
    private var SQBRCKT1:Number = 40;
    private var STR:Number = 41;
    private var OP_CMP:Number = 42;
    private var COND:Number = 43;
    private var CASE:Number = 44;
    private var IF:Number = 45;
    private var DEFAULT:Number = 46;
    private var OBJ:Number = 47;
	private var TYPE:Number = 48;
	private var CROSS:Number = 49;
	private var COLOR:Number = 50;
    private var EOF:Number = 255;
    private var CD:Object = {_for: FOR, _foreach: FOREACH, _function: FUNCDEF, _while: WHILE, _do: DO, _break: BREAK, _if: IF, _else: ELSE, _elseif: ELSEIF, _switch: SWITCH, _case: CASE, _default: DEFAULT, _Number: TYPE, _String: TYPE, _Boolean: TYPE };
	
	private var _string:String;
	private var _length:Number;	
	
	private var cnt:Number
}