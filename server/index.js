// console.log("Hello") 
const express=require("express")
const mongoose=require('mongoose');
const cors = require("cors");
const http = require("http");
// const authRouter = require("./routes/user");
const authRouter = require("./routes/auth");



const PORT=process.env.PORT| 3001;
const app =express();

//app.use(cors());
app.use(express.json());// what evr data comes from lient side it will convert into json  format and send to server
app.use(authRouter);// middleware

const DB="mongodb+srv://amish:v6eENVBZI4QAB6mk@cluster0.zpafans.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
}).catch((err)=>{
console.log(err);
});


//for future in dart
//async -->await
// .then((data)=>print(data))



app.listen(PORT,"0.0.0.0",()=>{
    console.log("Connected at port 3001");
    console.log("Hey this is changing");
})


