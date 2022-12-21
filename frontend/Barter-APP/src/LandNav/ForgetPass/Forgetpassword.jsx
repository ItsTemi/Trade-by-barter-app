import React from "react";
import "./forgetpassword.css";
import { useForm } from "react-hook-form";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

import "animate.css/animate.min.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer, toast, cssTransition } from "react-toastify";

const bounce = cssTransition({
  enter: "animate__animated animate__bounceIn",
  exit: "animate__animated animate__bounceOut",
});

const url =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/forgot-password";

function Forgetpassword() {
  const [submitingForm, setSubmitingForm] = useState(false);
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm({});
  const navigate = useNavigate();

  const submit = (data, e) => {
    e.preventDefault();
    setSubmitingForm(true);
    console.log("###");
    axios
      .post(url, data)
      .then((response) => {
        console.log(response.data);
        // localStorage.setItem("user", response.data);
        // navigate("/resetpassword");
        setTimeout(() => navigate("/resetpassword"), 3000);
        toast.success(response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
      })
      .catch((error) => {
        // console.log(error);
        toast.error(error.response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
      });
    reset();
  };
  return (
    <div>
      <div className="forgetPasswordDiv">
        <h1>Enter your email</h1>

        {submitingForm && <p className="pleasewait"> Please wait...</p>}
        <form
          onSubmit={
            submitingForm ? (e) => e.preventDefault() : handleSubmit(submit)
          }
        >
          {/* {submitingForm ? "Please wait..." : "Submit"} */}
          {/* </form> */}
          <input
            type="email"
            placeholder="Email Address"
            name="email"
            className="details-input"
            {...register("email", {
              required: true,
              // pattern:
              //     //   /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
            })}
          />

          <p className="errormessage">
            {errors.email?.type === "required" &&
              "please enter an email address"}
          </p>
          <p className="errormessage">
            {errors.email?.type === "pattern" && "your email is not valid"}
          </p>
          <div className="forgetpass-button">
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
      <ToastContainer transition={bounce} />
    </div>
  );
}

export default Forgetpassword;
