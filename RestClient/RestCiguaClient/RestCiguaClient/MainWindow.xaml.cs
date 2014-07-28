using RestCiguaClient.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;
using RestCiguaClient.CiguaWSReference;
using System.Drawing;
using System.IO;
using System.Net;

namespace RestCiguaClient
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Usuario usuarioLogueado;
        string imagenSeleccionada = null;
        Boolean usarRest;

        //SOAP
        CiguaWSClient ciguaSoapClientProxy = null;
        CiguaWSReference.usuario user = null;
        public MainWindow()
        {

           

        }

        private void insertarDatosUsuario(String nombre, String usuario, BitmapImage fotoUsuario, int cantidadCiguas, int cantidadSeguidores, int cantidadSiguiendo)
        {

            lblnombreUsuario.Content = nombre;
            lblusuario.Content = usuario;
            imgFotoUsuario.Source = fotoUsuario;
            lblcantidadCiguas.Content = cantidadCiguas;
            lblcantidadSeguidores.Content = cantidadSeguidores;
            lblcantidadSiguiendo.Content = cantidadSiguiendo;

        
        }

        private void insertarcigua(String nombre, String usuario, String contenido, BitmapImage fotoUsuario, BitmapImage fotoCiguaSrc)
        {
            System.Windows.Controls.Canvas ciguaDisplay = new Canvas();
            System.Windows.Controls.Label nombreCigua = new Label();
            System.Windows.Controls.Label usuarioCigua = new Label();
            System.Windows.Controls.TextBlock contenidoCigua = new TextBlock();
            System.Windows.Controls.Image fotoCiguaUsuario = new Image();
            System.Windows.Controls.Image fotoCigua = new Image();
            ciguaDisplay.Height = 80;
            ciguaDisplay.Width = 400;
            fotoCiguaUsuario.Width = fotoCiguaUsuario.Height = 42;
            Canvas.SetLeft(fotoCiguaUsuario, 11);
            Canvas.SetTop(fotoCiguaUsuario, 10);

            fotoCigua.Width = fotoCiguaUsuario.Height = 60;
            Canvas.SetLeft(fotoCigua, 420);
            Canvas.SetTop(fotoCigua, 10);

            nombreCigua.FontWeight = FontWeights.Bold;
            nombreCigua.FontFamily = new FontFamily("Arial");
            Canvas.SetLeft(nombreCigua, 54);
            usuarioCigua.FontWeight = FontWeights.Bold;
            usuarioCigua.FontFamily = new FontFamily("Arial");
            usuarioCigua.Foreground = new SolidColorBrush(Colors.Gray);
            usuarioCigua.Opacity = 0.68;
            Canvas.SetLeft(usuarioCigua, 190);
            contenidoCigua.TextWrapping = TextWrapping.Wrap;
            contenidoCigua.Height = 68;
            contenidoCigua.Width = 350;
            Canvas.SetLeft(contenidoCigua, 60);
            Canvas.SetTop(contenidoCigua, 24);

            nombreCigua.Content = nombre;
            usuarioCigua.Content = usuario;
            contenidoCigua.Text = contenido;
            fotoCiguaUsuario.Source = fotoUsuario;
            fotoCigua.Source = fotoCiguaSrc;


            ciguaDisplay.Children.Add(nombreCigua);
            ciguaDisplay.Children.Add(usuarioCigua);
            ciguaDisplay.Children.Add(contenidoCigua);
            ciguaDisplay.Children.Add(fotoCiguaUsuario);
            ciguaDisplay.Children.Add(fotoCigua);
            Canvas.SetTop(ciguaDisplay, ciguaDisplay.Height * canvasCiguas.Children.Count);
            canvasCiguas.Children.Add(ciguaDisplay);
            canvasCiguas.UpdateLayout();

            if (ciguaDisplay.Height * canvasCiguas.Children.Count >= canvasCiguas.Height)
                canvasCiguas.Height = ciguaDisplay.Height * canvasCiguas.Children.Count;

        }

        private void btnEnviarCigua_Click(object sender, RoutedEventArgs e)
        {
            //insertarcigua("David De La Hoz", "@dhoz", ciguaContent.Text, null);
            //ciguaContent.Text = "";
            //lblNombreImagen.Content = "-";
            //insertarDatosUsuario("David De La Hoz", "@dhoz", null, 25, 12, 28);
            if (ciguaContent.Text.Trim() != "")
            {


                bool isPublic = ciguaPublica.IsChecked == true ? true : false;
                if (!usarRest)//Soap
                {
                    byte[] imagen = null;
                    if (imagenSeleccionada != null)
                    {
                        imagen = File.ReadAllBytes(imagenSeleccionada);
                    }
                    bool result = ciguaSoapClientProxy.crearTweet(ciguaContent.Text, lblNombreImagen.Content.ToString(), imagen, isPublic, user.username);
                    if (result)
                    {
                        //se creo bien el tweet, sacamos el TL nuevamente
                        updateTimelineSOAP();
                        updateUserStatsSOAP();
                        ciguaContent.Text = "";
                        ciguaPublica.IsChecked = true;
                        lblNombreImagen.Content = "";
                    }
                }
                else//Rest
                {
                    byte[] imagen = null;
                    if (imagenSeleccionada != null)
                    {
                        imagen = File.ReadAllBytes(imagenSeleccionada);
                    }
                    Tweet result = CiguaREST.crearTweet(ciguaContent.Text, lblNombreImagen.Content.ToString(), imagen, isPublic, usuarioLogueado.username);
                    if (result != null)
                    {
                        //se creo bien el tweet, sacamos el TL nuevamente
                        updateTimelineSOAP();
                        updateUserStatsSOAP();
                        ciguaContent.Text = "";
                        ciguaPublica.IsChecked = true;
                        lblNombreImagen.Content = "";
                    }
                }
            }
            else
            {
                MessageBox.Show("Debe introducir el contenido para la cigua");
            }
        }

        private void ciguaContent_TextChanged(object sender, TextChangedEventArgs e)
        {
            lblCantidadCaracteresRestantes.Foreground = new SolidColorBrush(Colors.Black);
            int cantRestante = ciguaContent.MaxLength - ciguaContent.Text.Count();
            lblCantidadCaracteresRestantes.Content = cantRestante;
            if(cantRestante <= 20)
                lblCantidadCaracteresRestantes.Foreground = new SolidColorBrush(Colors.Red);
        }

        private void btnImagen_Click(object sender, RoutedEventArgs e)
        {
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();
     
            dlg.Filter = "Imagenes (*.jpg, *.jpeg, *.jpe, *.jfif, *.png, *.gif) | *.jpg; *.jpeg; *.jpe; *.jfif; *.png; *.gif";

           
            Nullable<bool> result = dlg.ShowDialog();

           
            if (result == true)
            {
                imagenSeleccionada = dlg.FileName;
                lblNombreImagen.Content = System.IO.Path.GetFileName(imagenSeleccionada);
            }

        }

        private void updateUserStatsSOAP()
        {
            if (!usarRest)//Soap
            {
                lblcantidadCiguas.Content = ciguaSoapClientProxy.getCantTweets(lblusuario.Content.ToString());
                lblcantidadSiguiendo.Content = ciguaSoapClientProxy.getFollowingCount(lblusuario.Content.ToString());
                lblcantidadSeguidores.Content = ciguaSoapClientProxy.getFollowersCount(lblusuario.Content.ToString());
            }
            else//Rest
            {
                Estadistica est = CiguaREST.getEstadistica(usuarioLogueado.username);
                lblcantidadCiguas.Content = est.CantTweets;
                lblcantidadSiguiendo.Content = est.FollowingCount;
                lblcantidadSeguidores.Content = est.FollowersCount;
            }
        }

        private void updateTimelineSOAP()
        {
            canvasCiguas.Children.Clear();
            if (!usarRest)//Soap
            {     
                CiguaWSReference.tweet[] timeline = ciguaSoapClientProxy.getTweetsByUser(user.username);
                if (timeline != null)
                {
                    foreach (CiguaWSReference.tweet t in timeline)
                    {
                        CiguaWSReference.usuario u = ciguaSoapClientProxy.getUserByTweetId(t.id);
                        insertarcigua(u.nombre.ToString(), "@" + u.username.ToString(), t.contenido.ToString(), loadProfileImage(u.fotoUsuario), loadCiguaImage(t.imagen));
                    }
                } 
            }
            else//Rest
            {
               List<Tweet> timeline = CiguaREST.obtenerTimeline(usuarioLogueado.username);
                if (timeline != null)
                {
                    foreach (Tweet t in timeline)
                    {
                        Usuario u = CiguaREST.getUserByTweetId(t.id);
                        insertarcigua(u.nombre.ToString(), "@" + u.username.ToString(), t.contenido.ToString(), loadProfileImage(u.fotoUsuario), loadCiguaImage(t.imagen));
                    }
                } 
            }
        }

        public bool URLExists(string url)
        {
            bool result = true;

            try
            {
                WebRequest webRequest = WebRequest.Create(url);
                webRequest.Timeout = 5000; // miliseconds
                webRequest.Method = "HEAD";

                webRequest.GetResponse();
            }
            catch
            {
                result = false;
            }

            return result;
        }

        private BitmapImage loadProfileImage(string URL)
        {
            

            var path = @"http://localhost:8080/parcial2_grupo1_Microblogging/";

            if (URL == null || !URLExists(path + URL))
                URL = @"media/images/null.gif";

            BitmapImage bitmap = new BitmapImage();
            bitmap.BeginInit();
            bitmap.UriSource = new Uri(path+URL, UriKind.Absolute);
            bitmap.EndInit();

           return bitmap;
        }

        private BitmapImage loadCiguaImage(string URL)
        {


            var path = @"http://localhost:8080/parcial2_grupo1_Microblogging/";

            if (URL == null || !URLExists(path + URL))
                return null;

            BitmapImage bitmap = new BitmapImage();
            bitmap.BeginInit();
            bitmap.UriSource = new Uri(path + URL, UriKind.Absolute);
            bitmap.EndInit();

            return bitmap;
        }

        private void loginEntrar_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if ((bool)rdoRest.IsChecked)
                    usarRest = true;
                else
                    usarRest = false;

                if (!tbxloginUsuario.Text.Equals("") && !pbxLoginPassword.Password.Equals(""))
                {

                    if (!usarRest)//SOAP
                    {
                        ciguaSoapClientProxy = new CiguaWSClient();
                        bool result = ciguaSoapClientProxy.authenticateUser(tbxloginUsuario.Text, pbxLoginPassword.Password);
                        if (result)
                        {
                            canvasLogin.Visibility = System.Windows.Visibility.Hidden;
                            //Obtenemos el Usuario
                            user = ciguaSoapClientProxy.getUser(tbxloginUsuario.Text);
                            lblnombreUsuario.Content = user.nombre;
                            lblusuario.Content = user.username;
                            imgFotoUsuario.Source = loadProfileImage(user.fotoUsuario);


                            updateUserStatsSOAP();
                            //Procedemos a Actualizar el timeline
                            updateTimelineSOAP();
                        }
                        else
                        {
                            MessageBox.Show("Usuario o Contraseña Incorrectos");

                        }

                    }
                    else if (usarRest)//Rest
                    {
                        usuarioLogueado = CiguaREST.realizarLogin(tbxloginUsuario.Text, pbxLoginPassword.Password);
                        if (usuarioLogueado != null)
                        {
                            canvasLogin.Visibility = System.Windows.Visibility.Hidden;
                            //Obtenemos el Usuario
                            lblnombreUsuario.Content = usuarioLogueado.nombre;
                            lblusuario.Content = usuarioLogueado.username;
                            updateUserStatsSOAP();
                            //Procedemos a Actualizar el timeline
                            updateTimelineSOAP();
                            imgFotoUsuario.Source = loadProfileImage(usuarioLogueado.fotoUsuario);


                        }
                        else
                        {
                            MessageBox.Show("Usuario o Contraseña Incorrectos");
                        }
                    }

                }
                else
                {

                    MessageBox.Show("Debe introducir el usuario y la contraseña");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void tbxloginUsuario_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void imgRefresh_MouseUp(object sender, MouseButtonEventArgs e)
        {
            updateUserStatsSOAP();
            //Procedemos a Actualizar el timeline
            updateTimelineSOAP();
        }

        private void imgClose_MouseUp(object sender, MouseButtonEventArgs e)
        {
            this.Close();
        }

        private void imgLogout_MouseUp(object sender, MouseButtonEventArgs e)
        {
            canvasLogin.Visibility = System.Windows.Visibility.Visible;
        }


     


       

    }
    public static class ExtensionMethods
    {
        private static Action EmptyDelegate = delegate() { };

        public static void Refresh(this UIElement uiElement)
        {
            uiElement.Dispatcher.Invoke(DispatcherPriority.Render, EmptyDelegate);
        }
    }
}

