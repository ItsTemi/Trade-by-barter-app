import React from "react";
import { Link } from "react-router-dom";
import Register from "../SignupPage/SignupMain";
import "./Login.css";
import { useForm } from "react-hook-form";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "animate.css/animate.min.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer, toast, cssTransition } from "react-toastify";
import { useState } from "react";
import { useContext } from "react";
// import { AccessProvider } from "react";
import { AccessProv } from "../ContextApi/Context";

const bounce = cssTransition({
  enter: "animate__animated animate__bounceIn",
  exit: "animate__animated animate__bounceOut",
});

const url =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/login";
function Login() {
  const { access, setAccess } = useContext(AccessProv);
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm({});
  const [submitingForm, setSubmitingForm] = useState(false);
  const navigate = useNavigate();

  const submit = (data, e) => {
    e.preventDefault();
    setSubmitingForm(true);

    console.log(data);
    axios
      .post(url, data)
      .then((response) => {
        console.log(response);

        // const res = () => {
        setAccess({
          isLoggedIn: true,
          token: response.data.token,
          userId: response.data.userId,
        });
        // };
        // const res =
        localStorage.setItem(
          "user",
          JSON.stringify({
            isLoggedIn: true,
            token: response.data.token,
            userId: response.data.userId,
          })
        );

        setTimeout(() => navigate("/"), 3000);
        toast.success(response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
        reset();
      })
      .catch((error) => {
        // console.log(error);
        toast.error(error.response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
      });
  };

  return (
    <div className="container">
      <div className="first-div"></div>
      <div className="second-div">
        <div className="login-div">
          <div className="login-title">
            <h1 className="h1-tag">WeBarter</h1>
            <p className="p-tag">Where exchanging of goods are made easy...</p>
          </div>
          {/* <form onSubmit={handleSubmit(submit)}> */}
          <form
            onSubmit={
              submitingForm ? (e) => e.preventDefault() : handleSubmit(submit)
            }
          >
            {/* </form> */}
            <div className="login-email">
              <h3>Username</h3>
              <input
                type="text"
                className="login-input"
                placeholder="Username"
                name="username"
                {...register("username", {
                  required: true,
                  // pattern:
                  //   /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
                })}
              />
            </div>
            <div className="login-password">
              <h3>Password</h3>
              <input
                type="password"
                className="login-input"
                placeholder=" Password"
                name="password"
                {...register("password", {
                  required: true,
                  // pattern: /^(?=.\d)(?=.[a-z])(?=.*[A-Z]).{6,15}$/,
                })}
              />
            </div>

            <div className="login-button">
              <button type="submit" className="btn">
                {submitingForm ? "Please wait..." : "Login"}
              </button>
            </div>
          </form>
          <div className="login-button2">
            {/* <h3>New User?</h3><button className='btn2'>Create Account</button> */}
            <p className="btn2Login">
              New User? Don't have an account?{" "}
              <Link to={"/signup"}>Create Account</Link>{" "}
            </p>
          </div>

          {/* <br /> */}
          {/* <div className="cancel">
            <Link to={"/"}>CANCEL</Link>
          </div> */}

          <div className="forgetPass">
            <Link to={"/forgetpassword"}>forget password?</Link>
          </div>
        </div>
      </div>
      <ToastContainer transition={bounce} />
    </div>
  );
}

export default Login;
