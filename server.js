// server.js
// where your node app starts

// we've started you off with Express (https://expressjs.com/)
// but feel free to use whatever libraries or frameworks you'd like through `package.json`.
const express = require("express");
const app = express();
const Account = require("./account")

app.use(express.json())

let checkingAccount = new Account('Asad','checking',5000)
checkingAccount.id = '8ba35e1e-b5b8-47e8-a2a5-062df13fda38'

let savingAccount = new Account('Kevin','saving',8000)
savingAccount.id = '553188b1-586d-4a09-805a-98ab792f5754'

module.exports.accounts = [checkingAccount,savingAccount]
let accounts = module.exports.accounts


app.post('/api/accounts',(request,response) => {

let name = request.body.name
let accounttype = request.body.accountType
let balance = request.body.balance
let account = new Account(name,accounttype,balance)

account.save((newAccount,error) => {
if(newAccount){
accounts.push(newAccount)
response.json({success:true})
} else{
response.json({success:false,error,error})
}
})
  
})

app.post('/api/transfer',(req,res) => {
  
  console.log(req.body)
  
  let accountFromId = req.body.accountFromId 
  let accountToId = req.body.accountToId 
  let amount = req.body.amount 
  
  let fromAccount = accounts.find(account => account.id == accountFromId)
  let toAccount = accounts.find(account => account.id == accountToId)
  
  fromAccount.transfer(toAccount, amount, (transferred, error) => {
    if(transferred) {
      res.json({success: true})
    } else {
      res.json({success: false, error: error})
    }
  })
  
  
})

app.get('/api/accounts',(request,response) => {
response.json(accounts)
})

// listen for requests :)
const listener = app.listen(process.env.PORT, () => {
  console.log("Your app is listening on port " + listener.address().port);
});
