package;

import haxe.CallStack;

import lime.app.Application;
import lime.ui.Window;

import peote.view.PeoteView;
import peote.view.Display;
import peote.view.Color;
import peote.view.Texture;
import utils.Loader;
import lime.graphics.Image;


class Main extends Application
{
	override function onWindowCreate():Void
	{
		switch (window.context.type)
		{
			case WEBGL, OPENGL, OPENGLES:
				try startSample(window)
				catch (_) trace(CallStack.toString(CallStack.exceptionStack()), _);
			default: throw("Sorry, only works with OpenGL.");
		}
	}
	
	// ------------------------------------------------------------
	// --------------- SAMPLE STARTS HERE -------------------------
	// ------------------------------------------------------------	
	var peoteView:PeoteView;
	
	var light:NormalLight = null; 
	
	public function startSample(window:Window)
	{
		peoteView = new PeoteView(window);
		var display = new Display(0, 0, window.width, window.height, Color.GREY2);

		peoteView.addDisplay(display);
		
		Loader.imageArray(["assets/statue_light_alpha.png", "assets/statue_normal.png"] , true, function (image:Array<Image>)
		{
			var lightsTexture = new Texture(image[0].width, image[0].height); // , 1, 4, false, 0, 0);
			lightsTexture.setImage(image[0]);
			
			var normalTexture = new Texture(image[1].width, image[1].height); // , 1, 4, false, 0, 0);
			normalTexture.setImage(image[1]);

			
			// TODO: render all into Texture per frame!
			
			// TODO: only need normalTexture here
			NormalLight.init(display, lightsTexture, normalTexture);
			light = new NormalLight();

			
			// TODO: second render-pass to accumulate light-map from texture to the pre-calculated lights by blender
			
			
			
			
			
			
			
			// add mouse events to move the light (to not run before it was instantiated):
			window.onMouseMove.add(_onMouseMove);
		});
		
		
		//peoteView.start();
		
	}
	
	
	
	// ------------------------------------------------------------
	// ----------------- LIME EVENTS ------------------------------
	// ------------------------------------------------------------	
	function _onMouseMove (x:Float, y:Float):Void {
		light.update(Std.int(x), Std.int(y));
	}	

	// ----------------- MOUSE EVENTS ------------------------------
	
	// override function onMouseDown (x:Float, y:Float, button:lime.ui.MouseButton):Void {}	
	// override function onMouseMove (x:Float, y:Float):Void {
	// override function onMouseUp (x:Float, y:Float, button:lime.ui.MouseButton):Void {}	
	// override function onMouseWheel (deltaX:Float, deltaY:Float, deltaMode:lime.ui.MouseWheelMode):Void {}
	// override function onMouseMoveRelative (x:Float, y:Float):Void {}

	// ----------------- TOUCH EVENTS ------------------------------
	// override function onTouchStart (touch:lime.ui.Touch):Void {}
	// override function onTouchMove (touch:lime.ui.Touch):Void	{}
	// override function onTouchEnd (touch:lime.ui.Touch):Void {}
	
	// ----------------- KEYBOARD EVENTS ---------------------------
	// override function onKeyDown (keyCode:lime.ui.KeyCode, modifier:lime.ui.KeyModifier):Void {}	
	// override function onKeyUp (keyCode:lime.ui.KeyCode, modifier:lime.ui.KeyModifier):Void {}

	// -------------- other WINDOWS EVENTS ----------------------------
	// override function onWindowResize (width:Int, height:Int):Void { trace("onWindowResize", width, height); }
	
}
