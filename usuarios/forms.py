from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm, AuthenticationForm
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _
from .models import UsuarioPersonalizado

from django.utils.translation import gettext_lazy as _
from django.contrib.auth.forms import UserCreationForm
from .models import UsuarioPersonalizado
from django import forms


class LoginForm(AuthenticationForm):
    username = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))

# Formulario para crear usuario
class UsuarioForm(UserCreationForm):
    password1 = forms.CharField(
        label=_("Contraseña"),
        strip=False,
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
    )
    password2 = forms.CharField(
        label=_("Confirmar contraseña"),
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        strip=False,
    )

    class Meta:
        model = UsuarioPersonalizado
        fields = [
            'username', 'first_name', 'last_name', 'email',
            'telefono', 'tipo_documento', 'documento', 'rol',
            'is_active', 'is_staff', 'is_superuser',
        ]
        labels = {
            'username': _('Nombre de usuario'),
            'first_name': _('Nombre'),
            'last_name': _('Apellido'),
            'email': _('Correo electrónico'),
            'telefono': _('Teléfono'),
            'tipo_documento': _('Tipo de documento'),
            'documento': _('Documento'),
            'rol': _('Rol'),
            'is_active': _('Activo'),
            'is_staff': _('Acceso panel administrador'),
            'is_superuser': _('Administrador'),
        }
        help_texts = {field: '' for field in fields}

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        super(UsuarioForm, self).__init__(*args, **kwargs)

        # 1. Marcar el campo como obligatorio (elimina los ---------)
        self.fields['rol'].required = True

        # 2. Reemplazar las opciones para que SOLO aparezca la personalizada
        self.fields['rol'].choices = [('', 'Seleccione un rol')] + list(
            filter(lambda c: c[0] != '', self.fields['rol'].choices)
        )
        for field_name, field in self.fields.items():
            if not isinstance(field.widget, forms.CheckboxInput):
                field.widget.attrs.update({'class': 'form-control'})

    def clean_password1(self):
        password = self.cleaned_data.get('password1')
        try:
            validate_password(password, self.instance)
        except ValidationError as e:
            errores = []
            for msg in e.messages:
                if 'This password is too short' in msg:
                    errores.append(_("La contraseña es demasiado corta. Debe tener al menos 8 caracteres."))
                elif 'This password is too common' in msg:
                    errores.append(_("Esta contraseña es demasiado común."))
                elif 'This password is entirely numeric' in msg:
                    errores.append(_("Esta contraseña es completamente numérica."))
                else:
                    errores.append(_(msg))
            raise ValidationError(errores)
        return password

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
       
        try:
            validate_password(password2, self.instance)
        except ValidationError as e:
            errores = []
            for msg in e.messages:
                if 'This password is too short' in msg:
                    errores.append(_("La contraseña es demasiado corta. Debe tener al menos 8 caracteres."))
                elif 'This password is too common' in msg:
                    errores.append(_("Esta contraseña es demasiado común."))
                elif 'This password is entirely numeric' in msg:
                    errores.append(_("Esta contraseña es completamente numérica."))
                else:
                    errores.append(_(msg))
            raise ValidationError(errores)
        return password2
    
    
        

# Formulario para editar usuario
class UsuarioEditarForm(UserChangeForm):
    password1 = forms.CharField(
        label=_("Nueva Contraseña"),
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        required=False,
        strip=False,
    )
    password2 = forms.CharField(
        label=_("Confirmar Nueva Contraseña"),
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        required=False,
        strip=False,
    )

    class Meta:
        model = UsuarioPersonalizado
        fields = [
            'username', 'first_name', 'last_name', 'email',
            'telefono', 'tipo_documento', 'documento', 'rol',
            'is_active', 'is_staff', 'is_superuser',
        ]
        labels = {
            'username': _('Nombre de usuario'),
            'first_name': _('Nombre'),
            'last_name': _('Apellido'),
            'email': _('Correo electrónico'),
            'telefono': _('Teléfono'),
            'tipo_documento': _('Tipo de documento'),
            'documento': _('Documento'),
            'rol': _('Rol'),
            'is_active': _('Activo'),
            'is_staff': _('Acceso staff'),
            'is_superuser': _('Superusuario'),
        }
        help_texts = {field: '' for field in fields}

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        

        # 1. Marcar el campo como obligatorio (elimina los ---------)
        self.fields['rol'].required = True

        # 2. Reemplazar las opciones para que SOLO aparezca la personalizada
        self.fields['rol'].choices = [('', 'Seleccione un rol')] + list(filter(lambda c: c[0] != '', self.fields['rol'].choices))
        # Quitar el campo "password" por defecto de UserChangeForm
        if 'password' in self.fields:
            self.fields.pop('password')

        for field_name, field in self.fields.items():
            if not isinstance(field.widget, forms.CheckboxInput):
                field.widget.attrs.update({'class': 'form-control'})

    def clean_password1(self):
        password = self.cleaned_data.get('password1')
        if password:
            try:
                validate_password(password, self.instance)
            except ValidationError as e:
                errores = []
                for msg in e.messages:
                    if 'This password is too short' in msg:
                        errores.append(_("La contraseña es demasiado corta. Debe tener al menos 8 caracteres."))
                    elif 'This password is too common' in msg:
                        errores.append(_("Esta contraseña es demasiado común."))
                    elif 'This password is entirely numeric' in msg:
                        errores.append(_("Esta contraseña es completamente numérica."))
                    else:
                        errores.append(_(msg))
                raise ValidationError(errores)
        return password

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 or password2:
            if password1 != password2:
                raise forms.ValidationError(_("Las contraseñas no coinciden."))
        return password2
    
    