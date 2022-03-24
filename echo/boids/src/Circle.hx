package;

import peote.view.Buffer;
import peote.view.Element;
import peote.view.Color;

import echo.World;
import echo.Body;
import echo.data.Options.BodyOptions;

class Circle implements Element
{
	@posX @set("Position") public var x:Float = 0.0;
	@posY @set("Position") public var y:Float = 0.0;
	
	@custom public var radius:Float = 50.0;
	
	// size calculation by radius
	@sizeX @const @formula("radius * 2.0") var w:Float;
	@sizeY @const @formula("radius * 2.0") var h:Float;
	
	// pivot calculation by radius
	@pivotX @const @formula("radius") var px:Float;
	@pivotY @const @formula("radius") var py:Float;
	
	// color (RGBA)
	@color public var color:Color = 0x000000ff;
	
	var DEFAULT_COLOR_FORMULA = "color*circle()";
	var OPTIONS = { alpha:true };

	public static var fShader =
	'
		float circle()
		{
			float x = (vTexCoord.x-0.5)*2.0;
			float y = (vTexCoord.y-0.5)*2.0;
			float c;
			
			if ( sqrt(x*x + y*y) < 1.0 ) {
				c = 1.0;
			}
			else {
				c = 0.0;
			}
			return c;
		}
	';

	
	public var body:Body;
	
	public function new(buffer:Buffer<Circle>, color:Color, world:World, options:BodyOptions)
	{
		this.color = color;
		
		radius = options.shape.radius;
		
		x = options.x;
		y = options.y;
		
		body = world.make(options);
		
		body.on_move = onMove.bind(buffer, _);
		
		buffer.addElement(this);
	}
	
	public function onMove(buffer: Buffer<Circle>, x:Float, y:Float)
	{
		setPosition(x, y);
		buffer.updateElement(this);
	}
	
	
}