using Godot;
using System;

public partial class CameraCollider : Node3D
{
    [Export] public Node3D cameraNode;
    [Export] public RayCast3D rayCast3D
    [Export] public float standOffDistance = 0.1f;

    //Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
    }

    //Called every frame. 'delta' is the elapsed time since previous frame.
    public override void _Process(double delta)
    {
        if(rayCast3D.IsColliding())
        {
            cameraNode.Position = new Vector3(cameraNode.Position.X, cameraNode.Position.Y, rayCast3D.GetCollisionPoint().DistanceTo(rayCast3D.GlobalPosition) - standOffDistance);
        }
        else
        {
            cameraNode.GlobalPosition = rayCast3D.ToGlobal(rayCast3D.TargetPosition);
        }
    }
}