--  Tagged streaming: external tag + extension components.
pragma Ada_2022;

with Ada.Streams;

package Shapes is

   type Shape is abstract tagged record
      X, Y : Float := 0.0;
   end record;

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Shape);

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Shape);

   for Shape'Write use Write;
   for Shape'Read  use Read;

   type Circle is new Shape with record
      Radius : Float := 1.0;
   end record;

   overriding procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Circle);

   overriding procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Circle);

   function Area (S : Shape'Class) return Float;

end Shapes;
