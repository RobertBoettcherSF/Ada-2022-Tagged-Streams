pragma Ada_2022;

package body Shapes is

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Shape)
   is
   begin
      Float'Write (Stream, Item.X);
      Float'Write (Stream, Item.Y);
   end Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Shape)
   is
   begin
      Float'Read (Stream, Item.X);
      Float'Read (Stream, Item.Y);
   end Read;

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Circle)
   is
   begin
      Write (Stream, Shape (Item));
      Float'Write (Stream, Item.Radius);
   end Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Circle)
   is
   begin
      Float'Read (Stream, Item.X);
      Float'Read (Stream, Item.Y);
      Float'Read (Stream, Item.Radius);
   end Read;

   function Area (S : Shape'Class) return Float is
   begin
      if S in Circle'Class then
         declare
            C : Circle renames Circle (S);
         begin
            return 3.14159265 * C.Radius * C.Radius;
         end;
      else
         return 0.0;
      end if;
   end Area;

end Shapes;
