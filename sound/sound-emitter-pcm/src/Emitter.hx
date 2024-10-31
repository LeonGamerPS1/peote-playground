package;

import lime.media.AudioSource;
import lime.media.AudioBuffer;

import peote.view.Element;
import peote.view.Color;

class Emitter implements Element
{
	@posX public var x:Int;
	@posY public var y:Int;
	@sizeX public var w:Int;
	@sizeY public var h:Int;
	
	// hardcode the pivot into the middle 
	@pivotX @const @formula("w/2.0") var _px:Float;
	@pivotY @const @formula("h/2.0") var _py:Float;
	
	@color public var c:Color;

	// ----------------------------------------------------------------------	
	public var gain:Float; // sound gain (from 0.0 to 1.0)
	public var colorQuite:Color; // color at the quietest gain
	public var colorLoud:Color; // color at the loudest gain

	public var source:AudioSource;

	// ----------------------------------------------------------------------
	// ----------------------------------------------------------------------
	// ----------------------------------------------------------------------

	public function new(source:AudioSource, x:Int, y:Int, w:Int, h:Int, colorQuite:Color, colorLoud:Color, gain:Float )
	{
		this.source = source;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.colorQuite = colorQuite;
		this.colorLoud = colorLoud;
		setGain(gain);
	}

	// make the color in depend of gain
	public function setGain(gain:Float) {
		this.gain = gain;
		c = Color.FloatRGBA( 
			colorQuite.rF + (colorLoud.rF - colorQuite.rF)*gain,
			colorQuite.gF + (colorLoud.gF - colorQuite.gF)*gain,
			colorQuite.bF + (colorLoud.bF - colorQuite.bF)*gain,
			colorQuite.aF + (colorLoud.aF - colorQuite.aF)*gain,
		);
		source.gain = gain;
	}

	public function play() {
		source.play();
	}
	
	public function playRepeated(waitAfterPlay:Int) {
		play();
		// not good into sync to sound-length after a while, so maybe better onUpdate or by onComplete here!
		var timer = new haxe.Timer(source.length + waitAfterPlay);
		timer.run = () -> play();		
	}
	

	var multiplicator:Int = 0;
	public function playRepeatedRND(waitAfterPlay:Int=0, randomOffset:Int=0) { // all into MILLI-SECONDS 4sure ;)
		// trace(source.length);
		play();
		var timer = new haxe.Timer(source.length + waitAfterPlay - randomOffset);
		timer.run = () -> {
			var r:Int = Std.random(randomOffset * 2) + multiplicator * randomOffset * 2;
			multiplicator++;
			haxe.Timer.delay( ()->play(), r );
		}
	}

}
