// import React from "react";
// import "./Navbar.css"
// import {CgProfile} from "react-icons/cg"
// import {AiOutlineShoppingCart} from "react-icons/ai"
// import {MdOutlineEditNotifications} from "react-icons/md"
// // import { NavLink } from "react-router-dom";

// function Navbar() {
//   return (
//     <div className="nav">
//       <div className="barter">
//         WeBarter
//       </div>
//       <div className="list">
//         <ul>
//           <li>
//             <a href="/products"><MdOutlineEditNotifications className="iconss" /> 
//              Needs</a>
//           </li>
//           <li>
//             <a href="/products"><AiOutlineShoppingCart className="iconss" /> Cart</a>
//           </li>
//           <li>
//             <a href="/products"><CgProfile className="icons" /> Profile</a>
//           </li>
//         </ul>
//       </div>
//     </div>
//   );
// }

// export default Navbar;


import React, { useEffect, useState, useRef } from "react";
import "./signup.css";
import axios from "axios";
import { useForm } from "react-hook-form";
import { useNavigate } from "react-router-dom";

const url = "https://jsonplaceholder.typicode.com/users";

function Signup() {
    return (
        <div className="fullpage">
            <div className="left"></div>
            <div className="right">
                <h2>Welcome</h2>
                <br />
                <p style={{ color: "gray" }}>
                    Become part of a better community by disposing your waste
                    properly
                </p>
                <p style={{ color: "gray" }}>
                    Find waste management agencies in your location to pick up
                    your waste on schedule
                </p>
                <Form /> 
            </div>
        </div>
    );
}

const Form = () => {
    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
        reset,
    } = useForm({});


    const navigate = useNavigate();

    const onSubmit = (data) => {
        // console.log(data);
        axios
            .post(url, data, {
                headers: { "Content-Type": "application/json" },
            })
            .then((response) => {
                console.log(response);
                console.log(data.identity === "user")

                if(data.identity === "user"){
                    navigate("/login")
                } else{
                    navigate("/lawma/userpage")
                }
            })
            .catch((error) => {
                console.log(error.response.data.message);
            });
        reset();
        // const regIdentity = JSON.parse(data)
        // console.log(typeof data.identity) 
        // navigate(`/${data.identity}/login`);

    };

    return (
        <form className="form" onSubmit={handleSubmit(onSubmit)}>
            <div className="names">
                <div className="inputleft">
                    <label htmlFor="firstName">First Name</label>
                    <br />
                    <input
                        type="text"
                        name="firstName"
                        placeholder="Enter first name"
                        {...register("firstName", {
                            required: true,
                            maxLength: 30,
                        })}
                    />
                    <p className="errormessage">
                        {errors.firstName?.type === "required" &&
                            "your name is required"}
                    </p>
                    <p className="errormessage">
                        {errors.firstName?.type === "maxLength" &&
                            "your name should not be more than 30 character long"}
                    </p>
                </div>
                <div className="inputright">
                    <label htmlFor="lastName">Last Name</label>
                    <br />
                    <input
                        type="text"
                        name="lastName"
                        placeholder="Enter last name"
                        {...register("firstName", {
                            required: true,
                            maxLength: 30,
                        })}
                    />
                    <p className="errormessage">
                        {errors.lastName?.type === "required" &&
                            "Last name is required"}
                    </p>
                </div>
            </div>

            <div className="email">
                <label htmlFor="email">Email</label>
                <br />
                <input
                    className="inputemail"
                    type="text"
                    name="email"
                    placeholder="Enter a valid email"
                    {...register("email", {
                        required: true,
                        pattern:
                            /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
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
            </div>

            <div className="password">
                <div className="inputleft">
                    <label htmlFor="password">Password</label>
                    <br />
                    <input
                        type="password"
                        name="password"
                        placeholder="Create a password"
                        {...register("password", {
                            required: true,
                            pattern: /^(?=.\d)(?=.[a-z])(?=.*[A-Z]).{6,15}$/,
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
                </div>
                <div className="inputright">
                    <label htmlFor="confirm password">Confirm password</label>
                    <br />
                    <input
                        type="password"
                        name="confirmPassword"
                        placeholder="Type password again"
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

                </div>
            </div>
            <div className="option">
                <label htmlFor="who are you">Who are you</label>
                <br />
                
                <select name="" id=""
                {...register("identity", {
                    required: true,})}
                >
                    <option value="user">User</option>
                    <option value="lawma">LAWMA</option>
                </select>
            </div>
            <div className="checkbox">
                <input type="checkbox" required />
                <span className="agreement" style={{ fontSize: "small" }}>
                    Yes, i understand and agree to the Terms of Services,
                    including the user Agreement and Privacy.
                </span>
            </div>

            <button className="btn" type="submit">
                Create Account
            </button>
            <p className="question">Already have an account? Log in.</p>
        </form>
    );
};

export default Signup;