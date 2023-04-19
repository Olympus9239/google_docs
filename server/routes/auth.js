const express=require("express");
const User=require("../models/user");

const authRouter=express.Router();

authRouter.post('/api/signup',async(req,res)=>{
 try{
  const{name,email,profilePic}=req.body;
    // email already exsisits? we should not store it in the database
    let user= await User.findOne({email:email}) // we want to find one User with email property and it should be similar to the email we are gettimg from the client
    if(!user){
      user=User({
        name:name,
        email:email,
        profilePic:profilePic,  // can be written as User({ name, email,profilePic}) because right and left hand same
       

       });
      user=await user.save();
    }

 //   res.status(200).json({user:user}); can we written as user also inside when same,  we dont write status 200 because if nothing given means default is 200 only

    res.json({user:user});



    // if it doen not then we shoukd store data

 }catch(e){
  res.status(500).json({error:e.message});
    
 }


});


module.exports=authRouter;