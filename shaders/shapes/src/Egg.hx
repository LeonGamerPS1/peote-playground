package;

import peote.view.*;

class Egg implements Element
{
	@posX public var x:Int;
	@posY public var y:Int;
	
	// size in pixel
	@sizeX @varying public var w:Int;
	@sizeY @varying public var h:Int;
		

	static public var buffer:Buffer<Egg>;
	static public var program:Program;

	// -----------------------------------------------
	
	static public function init(formula:String, uniforms:Array<UniformFloat>, display:Display)
	{	
		buffer = new Buffer<Egg>(1, 1, true);
		program = new Program(buffer);
		
		program.injectIntoFragmentShader(
		'
			float egg( )
			{
				float x = (vTexCoord.x-0.5)*2.0;
				float y = (vTexCoord.y-0.5)*2.0;
				float c;
				
				if ( $formula < 1.0 ) {
					c = 1.0;
				}
				else {
					c = 0.0;
				}
				return c;
			}			
		',
		uniforms
		);
		
		program.setColorFormula( 'vec4(1.0)*egg()' );
		
		program.blendEnabled = true;
		program.discardAtAlpha(0.0);
		
		display.addProgram(program);
	}
	
	
	
	public function new(x:Int = 0, y:Int = 0, w:Int = 100, h:Int = 100) 
	{
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		buffer.addElement(this);
	}

}
