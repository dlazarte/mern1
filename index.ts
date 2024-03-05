import express, { Express, Request, Response } from"express";
import dotenv from 'dotenv';


// Configuration the .env file
dotenv.config();

// Create the express APP

const app: Express = express();
const port: string | number = process.env.PORT || 3001;

// Define the route of APP
app.get('/', (req:Request, res:Response) => {
    // send Hello World
    res.send('APP+express+TS+Mongoose. Hello World!');
});

// Define the first route of APP
app.get('/hello', (req:Request, res:Response) => {
    // send Hello World
    res.send('Welcome a first GET Route!');
});
// execute APP Listen Request in port

app.listen(port,() => {
    console.log('App listening on port:${port}');
});


