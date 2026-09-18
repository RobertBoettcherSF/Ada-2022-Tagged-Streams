pragma Ada_2022;

with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;
with Memory_Stream;
with Shapes;

procedure Tests is
   S : aliased Memory_Stream.Buffer_Stream (512);
   C : constant Shapes.Circle := (X => 1.0, Y => 2.0, Radius => 3.0);
   D : Shapes.Circle;
begin
   Shapes.Circle'Write (S'Access, C);
   Memory_Stream.Reset_Read (S);
   Shapes.Circle'Read (S'Access, D);
   Assert (abs (D.X - 1.0) < 1.0E-5);
   Assert (abs (D.Y - 2.0) < 1.0E-5);
   Assert (abs (D.Radius - 3.0) < 1.0E-5);
   Put_Line ("PASS Circle'Write/'Read round trip");

   Assert (abs (Shapes.Area (D) - 28.274333) < 1.0E-3);
   Put_Line ("PASS class-wide Area after stream");

   --  Class-wide Output/Input includes the external tag.
   declare
      S2 : aliased Memory_Stream.Buffer_Stream (512);
      Obj : constant Shapes.Shape'Class := C;
      Acc : Shapes.Shape'Class := Shapes.Circle'(X => 0.0, Y => 0.0, Radius => 1.0);
   begin
      Shapes.Shape'Class'Output (S2'Access, Obj);
      Memory_Stream.Reset_Read (S2);
      Acc := Shapes.Shape'Class'Input (S2'Access);
      Assert (Acc in Shapes.Circle'Class);
      Assert (abs (Shapes.Circle (Acc).Radius - 3.0) < 1.0E-5);
   end;
   Put_Line ("PASS Shape'Class'Output/'Input");

   Put_Line ("All Tagged Streams topic tests passed.");
end Tests;
