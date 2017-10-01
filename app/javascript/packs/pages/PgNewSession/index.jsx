// // Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// // like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// // of the page.

// import React from 'react'
// import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'

// const NewSession = props => (
//   <div class="col-xl-10 offset-xl-1 col-lg-10 offset-lg-1 col-xs-12">
//     <div class="content-wrap">
//       <div class="row">
//         <div class="col-lg-6 col-xs-12">
//           <form class="new_user" id="new_user" action="/users/sign_in" accept-charset="UTF-8" method="post">
//             <input name="utf8" type="hidden" value="✓">
//             <input type="hidden" name="authenticity_token" value="Huhnb1W82gmLz5LA9a6a5LU2GSU9J65yw+NKPoxZ0MTXXr5mx70fXjYCAOv9TIiOOQotdmkouygrDOpH5wwrEQ==">
//             <h3>Войти</h3>

//             <div class="form-field">
//               <label for="username-login"> Email</label>
//               <input autofocus="autofocus" id="username-login" required="required" placeholder="example@example.com" type="email" value="" name="user[email]"></div>
//               <div class="form-field">
//                 <label for="username-password"> Пароль</label>
//                 <input autocomplete="off" id="username-password" type="password" name="user[password]"></div>
//                 <div class="form-field">
//                   <button class="btn" type="submit"> Войти</button>
//                   <div class="mtop_10 pull-right">
//                     <a href="/users/password/new">Забыли пароль?</a>
//                   </div>
//                   </div>
//                   </form>
//                   </div>
//                   <div class="col-lg-6 col-xs-12">
//                     <form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post">
//                     <input name="utf8" type="hidden" value="✓">
//                     <input type="hidden" name="authenticity_token" value="Huhnb1W82gmLz5LA9a6a5LU2GSU9J65yw+NKPoxZ0MTXXr5mx70fXjYCAOv9TIiOOQotdmkouygrDOpH5wwrEQ==">
//                     <h3>Регистрация</h3>
//                     <div class="form-field">
//                       <label for="email-register"> E-mail</label>
//                     <input autofocus="autofocus" required="required" placeholder="example@example.com" type="email" value="" name="user[email]" id="user_email"></div>
//                     <div class="form-field">
//                       <label for="username-register"> ФИО</label>
//                     <input autofocus="autofocus" required="required" placeholder="Иванов Высилий Петорович" type="text" name="user[name]" id="user_name"></div>
//                     <div class="form-field center">
//                       <p>Нажимая кнопку «Создать аккаунт»,<br>Вы принимаете условия<br><a href="/agreement">Пользовательского соглашения</a></p></div>
//                       <div class="form-field center">
//                         <button class="btn" type="submit"> Создать аккаунт</button>
//                         </div>
//                         </form>
//                         </div>
//                         </div>
//                         </div>
//                         </div>
// )

// NewSession.defaultProps = {
//   name: 'David'
// }

// NewSession.propTypes = {
//   name: PropTypes.string
// }

// document.addEventListener('DOMContentLoaded', () => {
//   ReactDOM.render(
//     <NewSession name="React" />,
//     document.body.appendChild(document.createElement('div')),
//   )
// })
