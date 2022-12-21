import React from "react";
import { useForm } from "react-hook-form";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Signup.css";
import axios from "axios";
import "animate.css/animate.min.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer, toast, cssTransition } from "react-toastify";
// import { AccessProvider } from "react";
// import { useState } from "react";

const url =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/register";

const bounce = cssTransition({
  enter: "animate__animated animate__bounceIn",
  exit: "animate__animated animate__bounceOut",
});

function Register() {
  const [submitingForm, setSubmitingForm] = useState(false);
  // const { access, setAccess } = useContext(AccessProvider);
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm({});
  const navigate = useNavigate();

  const submit = (data) => {
    // console.log("###");
    setSubmitingForm(true);
    axios
      .post(url, data)
      .then((response) => {
        // setTimeout(() => navigate("/login"), 2000);
        // toast.success(response.data.message, {
        //   transition: bounce,
        // });
        console.log(response.data.userId);

        // const res =
        localStorage.setItem("userId", response.data.userId);

        if (data.identity === "User") {
          // navigate("/verify");
          setTimeout(() => navigate("/verify"), 3000);
          toast.success(response.data.msg, {
            transition: bounce,
          });
        }
        // else {
        //   setTimeout(() => navigate("/"), 3000);
        //   toast.error(response.data.msg, {
        //     transition: bounce,
        //   });
        //   navigate("/");
        // }

        reset();
      })
      .catch((error) => {
        console.log(error);
        // alert(error.response.data.msg);
        toast.error(error.response.data.msg, {
          transition: bounce,
        });
      });
  };

  return (
    <div className="register-container">
      <div className="register-main-body">
        <div className="register-first-div"></div>
        <div className="register-div">
          <div className="register-div2">
            <div className="register-title">
              <h2>WeBarter</h2>
              <p className="register-p">
                Where exchanging of goods are made easy...
              </p>
            </div>

            <div>
              {submitingForm && <p className="pleasewait"> Please wait...</p>}
              {/* <form
                className="register-details"
                onSubmit={handleSubmit(submit)}
              > */}
              <form
                className="register-details"
                onSubmit={
                  submitingForm
                    ? (e) => e.preventDefault()
                    : handleSubmit(submit)
                }
              >
                {/* </form> */}
                <input
                  type="text"
                  placeholder="Phone number"
                  name="phonenumber"
                  className="details-input"
                  {...register("phonenumber", {
                    required: true,
                    maxlength: 14,
                  })}
                />
                <p className="errormessage">
                  {errors.phonenumber?.type === "required" &&
                    "your phonenumber is required"}
                </p>
                <p className="errormessage">
                  {errors.phonenumber?.type === "maxLength" &&
                    "your name should not be more than 14 character long"}
                </p>
                <input
                  type="text"
                  placeholder="Username"
                  name="username"
                  className="details-input"
                  {...register("username", { required: true, maxlength: 30 })}
                />
                <p className="errormessage">
                  {errors.username?.type === "required" &&
                    "Last name is required"}
                </p>
                <p className="errormessage">
                  {errors.username?.type === "maxLength" &&
                    "your username should not be more than 14 character long"}
                </p>
                <input
                  type="email"
                  placeholder="Email Address"
                  name="email"
                  className="details-input"
                  {...register("email", {
                    required: true,
                    // pattern:
                    //   /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
                  })}
                />

                <p className="errormessage">
                  {errors.email?.type === "required" &&
                    "please enter an email address"}
                </p>
                <p className="errormessage">
                  {errors.email?.type === "pattern" &&
                    "your email is not valid"}
                </p>
                <input
                  type="password"
                  placeholder="Password"
                  name="password"
                  className="details-input"
                  {...register("password", {
                    required: true,
                    // pattern: /^(?=.\d)(?=.[a-z])(?=.*[A-Z]).{6,15}$/,
                  })}
                />
                <p className="errormessage">
                  {errors.password?.type === "required" &&
                    "Please enter a password"}
                </p>
                <p className="errormessage">
                  {errors.password?.type === "pattern" &&
                    "Password must contain letters,Uppercase, Numbers, special character and should not be less than 6 and more than 15 characters"}
                </p>
                <input
                  type="password"
                  placeholder="Confirm Password"
                  name="confirmPassword"
                  className="details-input"
                  {...register("confirmPassword", {
                    required: true,
                    validate: (value) => {
                      if (watch("password") != value) {
                        return "Your passwords do no match";
                      }
                    },
                  })}
                />
                <p className="errormessage">
                  {errors.confirmPassword?.type === "validate" &&
                    "Password does not match"}
                </p>

                <div className="option">
                  <label htmlFor="who are you">Who are you</label>
                  <br />

                  <select
                    name=""
                    id=""
                    {...register("identity", {
                      required: true,
                    })}
                  >
                    <option value="User">User</option>
                    <option value="lawma">New-user</option>
                  </select>
                </div>
                <div className="checkbox">
                  <input type="checkbox" required />
                  <span className="agreement">
                    Yes, i understand and agree to the Terms of Services,
                    including the user Agreement and Privacy.
                  </span>
                </div>

                <div className="register-submit-button">
                  <button type="submit" className="register-btn">
                    Submit
                  </button>
                </div>

                <br />
                <div className="register-login">
                  <p className="register-login2">
                    Already have an account? <Link to={"/login"}>Log in</Link>
                  </p>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <ToastContainer transition={bounce} />
    </div>
  );
}

export default Register;
