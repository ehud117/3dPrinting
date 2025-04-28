x1 = 20; y1 = 35;

module wholePart()
{   linear_extrude(8) difference()
    {
        polygon([[x1, y1], [-x1, y1], [-x1, -y1], [x1, -y1]]);
        circle(d=15, $fn=128);
    }
}
module cut(left)
{
    module leftCut()
    {
        
    }
}
//wholePart();

module diameterTest()
{
        linear_extrude(8) 
        {
            intersection()
            {
                difference()
                {

                    circle(d=18, $fn=128);
                    circle(d=15, $fn=128);
                }
                polygon([[0,20],[0,-20],[20,-20],[20,20]]);
                
            }
        }
    }
    
        
    

diameterTest();
