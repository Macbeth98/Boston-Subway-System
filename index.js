const express = require("express");
var logger = require('morgan');
const cors = require("cors");

const helmet = require('helmet');

const app = express();

var corsOptions = {
  origin: "*"
};

app.use(cors(corsOptions));

app.use(logger('dev'));

// to parse the requests of content type - application/json.
app.use(express.json());

// to parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({extended: true}));


app.use(helmet());

// Default route.
app.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "Boston Subway System is up and running.",
    timestamp: new Date()
  })
});

const printAPIOriginDetails = async (req, res, next) => {
  try {
    console.info("HostName", req.hostname);
    console.info("Path...", req.path);
    console.info("IP Address...", req.headers["x-forwarded-for"]);
    console.info("Origin URL", req.headers["origin"]);

    next();

    return ;

  } catch (e) {
    console.error(e);
    next();
    return ;
  }
}

app.use(printAPIOriginDetails);

// IMPORTING ALL THE REQUIRED ROUTES.
const cityRouter = require("./routes/city.routes");

app.use('/api/city', cityRouter);


// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
