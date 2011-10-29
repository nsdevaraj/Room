package away3d.sprites
{
    import away3d.arcane;
	import away3d.core.base.*;
    import away3d.core.utils.*;
	import away3d.core.vos.*;
    import away3d.materials.*;
    
    use namespace arcane;
    
    /**
    * A graphics element used to represent objects that always face the camera
    * 
    * @see away3d.core.base.Mesh
    */
    public class Sprite3D extends Element
    {
		/** @private */
        arcane var _vertex:Vertex;
        
		private var _width:Number;
		private var _height:Number;
		private var _rotation:Number;
		private var _align:String;
		private var _scaling:Number;
		private var _distanceScaling:Boolean;
		
		public var spriteVO:SpriteVO = new SpriteVO();
        
    	/**
    	 * Defines the x coordinate of the 3d sprite relative to the local coordinates of the parent <code>Mesh</code>.
    	 */
        public function get x():Number
        {
            return _vertex.x;
        }
    
        public function set x(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(x)");
			
			if (_vertex.x == value)
				return;
			
            if (value == Infinity)
                Debug.warning("x == Infinity");

            if (value == -Infinity)
                Debug.warning("x == -Infinity");

            _vertex.x = value;
        }
		
    	/**
    	 * Defines the y coordinate of the 3d sprite relative to the local coordinates of the parent <code>Mesh</code>.
    	 */
        public function get y():Number
        {
            return _vertex.y;
        }
    
        public function set y(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(y)");
			
			if (_vertex.y == value)
				return;
			
            if (value == Infinity)
                Debug.warning("y == Infinity");

            if (value == -Infinity)
                Debug.warning("y == -Infinity");

            _vertex.y = value;
        }
		
    	/**
    	 * Defines the z coordinate of the 3d sprite relative to the local coordinates of the parent <code>Mesh</code>.
    	 */
        public function get z():Number
        {
            return _vertex.z;
        }
    	
        public function set z(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(z)");
			
			if (_vertex.z == value)
				return;
			
            if (value == Infinity)
                Debug.warning("z == Infinity");

            if (value == -Infinity)
                Debug.warning("z == -Infinity");

            _vertex.z = value;
            
        }
        
		/**
		 * Defines the material of the 3d sprite.
		 */
        public override function get material():Material
        {
            return _material;
        }

        public override function set material(value:Material):void
        {
            if (_material == value)
                return;
			
			if (parent)
				parent.removeMaterial(this, _material);
			
            _material = spriteVO.material = value;
			
			if (parent)
				parent.addMaterial(this, _material);
        }
        
		/**
		 * Defines the width of the 3d sprite.
		 */
        public function get width():Number
        {
            return _width;
        }

        public function set width(value:Number):void
        {
            if (_width == value)
                return;

            _width = spriteVO.width = value;
			
			if (parent)
				parent.notifyDimensionsUpdate();
        }
        
		/**
		 * Defines the height of the 3d sprite.
		 */
        public function get height():Number
        {
            return _width;
        }

        public function set height(value:Number):void
        {
            if (_height == value)
                return;
			
            _height = spriteVO.height = value;
			
            if (parent)
				parent.notifyDimensionsUpdate();
        }
        
		/**
		 * Defines how the 3d sprite is aligned to its vertex
		 * 
		 * @see away3d.sprites.SpriteAlign
		 */
        public function get align():String
        {
            return _align;
        }

        public function set align(value:String):void
        {
            if (_align == value)
                return;
			
            _align = spriteVO.align = value;
			
            if (parent)
				parent.notifyDimensionsUpdate();
        }
        
		/**
		 * Defines the scaling of the 3d sprite when an <code>BitmapMaterial</code> is used.
		 */
        public function get scaling():Number
        {
            return _scaling;
        }

        public function set scaling(value:Number):void
        {
            if (_scaling == value)
                return;
			
            _scaling = spriteVO.scaling = value;
			
           	if (parent)
				parent.notifyDimensionsUpdate();
        }
        
		/**
		 * Defines if the sprite should scale with distance. Defaults to true
		 */
        public function get distanceScaling():Boolean
        {
            return _distanceScaling;
        }

        public function set distanceScaling(value:Boolean):void
        {
            if (_distanceScaling == value)
                return;
			
            _distanceScaling = spriteVO.distanceScaling = value;
			
            if (parent)
				parent.notifyDimensionsUpdate();
        }
        
		/**
		 * Defines the rotation of the 3d sprite.
		 */
        public function get rotation():Number
        {
            return _rotation;
        }

        public function set rotation(value:Number):void
        {
            if (_rotation == value)
                return;
			
            _rotation = spriteVO.rotation = value;
			
            if (parent)
				parent.notifyDimensionsUpdate();
        }
    	
		/**
		 * Creates a new <code>Billboard</code> object.
		 *
		 * @param	material	[optional]	The material used by the 3d sprite to render
		 */
        public function Sprite3D(material:Material = null, width:Number = 10, height:Number = 10, rotation:Number = 0, align:String = "center", scaling:Number = 1, distanceScaling:Boolean = true)
        {
            spriteVO.sprite3d = this;
            _vertices = spriteVO.vertices;
			_commands = spriteVO.commands;
			
            this.material = material;
            this.width = width;
            this.height = height;
            this.align = align;
            this.rotation = rotation;
            this.scaling = scaling;
            this.distanceScaling = distanceScaling;
            
        	//setup the vertex
            _commands[0] = "M";
            _vertex = _vertices[0] = new Vertex();
            
			_vertex.parents.push(this);
        }
    }
}
